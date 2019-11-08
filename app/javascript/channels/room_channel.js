import consumer from "./consumer";

consumer.subscriptions.create(
  { channel: "RoomChannel" },
  {
    received(data) {
      var videoUrl = data.content.videoId;
      var rx = /^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*/;
      var videoId = videoUrl.match(rx)[1];

      document.getElementById("room-number").innerHTML = videoId;
      document.getElementById(
        "player"
      ).src = `https://www.youtube.com/embed/${videoId}`;
    }
  }
);
