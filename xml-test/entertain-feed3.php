<?
//read-feed-simpleXML.php
//our simplest example of consuming an RSS feed

  // $request = "http://rss.news.yahoo.com/rss/software";

 //This selects the RSS feed by topic, as set by Google. 
 /* $request = "https://news.google.com/news?cf=all&hl=en&pz=1&ned=us&topic=" . $topic . "&output=rss"; */ 
  
  // $topic = 'm'; 

// URL of feed: https://www.google.com/search?hl=en&gl=us&tbm=nws&authuser=0&q=Radiohead&oq=Radiohead&output=rss

// Category: Entertainment. 
// Topic: Radiohead. They're a band. 

  $topic = 'Radiohead'; 

  // q=election+poll+president

  $request = "https://news.google.com/news?cf=all&hl=en&pz=1&ned=us&q=" . $topic . "&output=rss";

  // Can get a file anywhere in the world. 
  $response = file_get_contents($request);
  $xml = simplexml_load_string($response);
  print '<h1>' . $xml->channel->title . '</h1>';
  foreach($xml->channel->item as $story)
  {
    echo '<a href="' . $story->link . '">' . $story->title . '</a><br />'; 
    echo '<p>' . $story->description . '</p><br /><br />';
  }
?>