'use strict';

var FeedParser = require('feedparser');

exports.parse = function(Just) {
  return function(Nothing) {
    return function(text) {
      var result = [];

      var parser = new FeedParser();
      parser.on('readable', function() {
        var item = this.read();
        result.push({
          title: '' + item.title,
          url: '' + item.link,
          time: '' + item.pubDate,
        });
      });
      parser.write(text);
      parser.end();

      return Just(result);
    };
  };
};