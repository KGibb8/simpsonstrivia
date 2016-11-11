App.search = App.cable.subscriptions.create("SearchChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var searchResults = $("#searchResults");
    searchResults.empty();
    data.message.forEach(function (search) {
      searchResults.append(
        '<a href="/episodes/' + search.episode_id.toString() +
        '"><div class="result"><img src="' + search.image_url +
        '" class="resultImg"></div></a>'
      );
    })
  },
  search: function(search) {
    return this.perform('search', search);
  }
});
