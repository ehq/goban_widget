part of board;

class TimeLimitedEventTransformer extends StreamEventTransformer<Event, Event> {
 Duration duration;
 Timer timeout;

 TimeLimitedEventTransformer(this.duration);

 void handleData(Event evt, EventSink<Event> sink) {
   if (timeout != null) return;

   timeout = new Timer(duration, () {
     sink.add(evt);
     this.timeout = null;
   });
 }
}