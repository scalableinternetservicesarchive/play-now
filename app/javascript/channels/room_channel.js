import consumer from "./consumer";

consumer.subscriptions.create(
  { channel: "RoomChannel" },
  {
    received(data) {
      document.getElementById("room-number").innerHTML = data.content;
    }
  }
);
