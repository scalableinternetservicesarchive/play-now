// TODO: need to poll every second
// SetInterval here with a fetch request
// also need to have client updating logic here — callPlayer

/**
 * @description  Executes function on a framed YouTube video (see website link)
 *               For a full list of possible functions, see:
 *               https://developers.google.com/youtube/js_api_reference
 * @param String frame_id The id of (the div containing) the frame
 * @param String func     Desired function to call, eg. "playVideo"
 *        (Function)      Function to call when the player is ready.
 * @param Array  args     (optional) List of arguments to pass to function func*/
function callPlayer(frame_id, func, args) {
  if (window.jQuery && frame_id instanceof jQuery)
    frame_id = frame_id.get(0).id;
  var iframe = document.getElementById(frame_id);
  if (iframe && iframe.tagName.toUpperCase() != "IFRAME") {
    iframe = iframe.getElementsByTagName("iframe")[0];
  }

  // When the player is not ready yet, add the event to a queue
  // Each frame_id is associated with an own queue.
  // Each queue has three possible states:
  //  undefined = uninitialised / array = queue / .ready=true = ready
  if (!callPlayer.queue) callPlayer.queue = {};
  var queue = callPlayer.queue[frame_id],
    domReady = document.readyState == "complete";

  if (domReady && !iframe) {
    // DOM is ready and iframe does not exist. Log a message
    window.console &&
      console.log("callPlayer: Frame not found; id=" + frame_id);
    if (queue) clearInterval(queue.poller);
  } else if (func === "listening") {
    // Sending the "listener" message to the frame, to request status updates
    if (iframe && iframe.contentWindow) {
      func = '{"event":"listening","id":' + JSON.stringify("" + frame_id) + "}";
      iframe.contentWindow.postMessage(func, "*");
    }
  } else if (
    (!queue || !queue.ready) &&
    (!domReady ||
      (iframe && !iframe.contentWindow) ||
      typeof func === "function")
  ) {
    if (!queue) queue = callPlayer.queue[frame_id] = [];
    queue.push([func, args]);
    if (!("poller" in queue)) {
      // keep polling until the document and frame is ready
      queue.poller = setInterval(function() {
        callPlayer(frame_id, "listening");
      }, 250);
      // Add a global "message" event listener, to catch status updates:
      messageEvent(
        1,
        function runOnceReady(e) {
          if (!iframe) {
            iframe = document.getElementById(frame_id);
            if (!iframe) return;
            if (iframe.tagName.toUpperCase() != "IFRAME") {
              iframe = iframe.getElementsByTagName("iframe")[0];
              if (!iframe) return;
            }
          }
          if (e.source === iframe.contentWindow) {
            // Assume that the player is ready if we receive a
            // message from the iframe
            clearInterval(queue.poller);
            queue.ready = true;
            messageEvent(0, runOnceReady);
            // .. and release the queue:
            while ((tmp = queue.shift())) {
              callPlayer(frame_id, tmp[0], tmp[1]);
            }
          }
        },
        false
      );
    }
  } else if (iframe && iframe.contentWindow) {
    // When a function is supplied, just call it (like "onYouTubePlayerReady")
    if (func.call) return func();
    // Frame exists, send message
    iframe.contentWindow.postMessage(
      JSON.stringify({
        event: "command",
        func: func,
        args: args || [],
        id: frame_id
      }),
      "*"
    );
  }
  /* IE8 does not support addEventListener... */
  function messageEvent(add, listener) {
    var w3 = add ? window.addEventListener : window.removeEventListener;
    w3
      ? w3("message", listener, !1)
      : (add ? window.attachEvent : window.detachEvent)("onmessage", listener);
  }
}

let ts = 0;

setInterval(async () => {
  const response = await fetch(`${window.location.href}/state`);
  const data = await response.json();
  console.log(data);
  if (data.videoId) {
    const videoUrl = data.videoId;
    const rx = /^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*/;
    const videoId = videoUrl.match(rx)[1];
    const player = document.getElementById("player");
    if (
      player.src != `https://www.youtube.com/embed/${videoId}?enablejsapi=1`
    ) {
      player.src = `https://www.youtube.com/embed/${videoId}?enablejsapi=1`;
    }
  }

  switch (data.state) {
    case 0:
      callPlayer("player", "stopVideo");
      break;
    case 1:
      callPlayer("player", "pauseVideo");
      break;
    case 2:
      callPlayer("player", "playVideo");
      break;
  }

  if (data.seconds != ts) {
    ts = data.seconds;
    callPlayer("player", "seekTo", [data.seconds, true]);
  }

  // console.log(JSON.stringify(myJson));
  // fetch("/room/justin/state")
  //   .then(val => val.json())
  //   .then(val => console.log(val));
}, 1000);
