import consumer from "./consumer";

consumer.subscriptions.create({ channel: "RoomChannel", room: "Best Room" });
