# HipCharts

Temp build of [https://github.com/jsncbt/hipcharts](https://github.com/jsncbt/hipcharts) until it gets updated with this version.


## Installation

```
git clone git@github.com:jsncbt/hipcharts.git
cd hipcharts
npm i
coffee server.coffee
```

May need to ensure mongod is running


## Sample RPC Code (Coffeescript)

```
# register, login, logout
ss.rpc 'app.register', {username: 'jsncbt', password: 'sshhh', chart:[{title:'Acid Rap'},{title:'Born Sinner'}]}
ss.rpc 'app.authenticate', {username: 'jsncbt', password: 'sshhh'}
ss.rpc 'app.logout'

# list someone's public collection
ss.rpc 'app.getCollection', {username: 'jsncbt'}, ({success, user}) ->
  console.log user.chart
```

There are also helper functions login(), register(), logout() which moslty just wrap the above RPC calls


## TODO

- Giantbomb adapter and data abstraction layer
- Track/Album switcher
- get Backbone.events in here
- scrolling doesn't work (on desktop only maybe?)
- The "Searching For" text update should not be subject to the debounce
