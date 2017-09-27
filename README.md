# Beverage

`GET /` - see location of next event

`GET /api/events` - get 10 most recent events
```json
[
   {
      "datetime":"2017-09-27T15:30:00+00:00",
      "location":"St. Clare Coffee, 654 Mission St, San Francisco, CA 94105"
   }
]
```
`GET /api/events/future` - get future events
```json
[
   {
      "datetime":"2017-09-27T15:30:00+00:00",
      "location":"St. Clare Coffee, 654 Mission St, San Francisco, CA 94105"
   }
]
```