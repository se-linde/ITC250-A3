<?
//read-feed-simpleXML.php
//our simplest example of consuming an RSS feed

  // $request = "http://rss.news.yahoo.com/rss/software";

 //This selects the RSS feed by topic, as set by Google. 
 /* $request = "https://news.google.com/news?cf=all&hl=en&pz=1&ned=us&topic=" . $topic . "&output=rss"; */ 
  

//intialize session
session_start();

/*if the array exists in the session, add topics
if the array doesn't exist, make the array
if no array exists, create it
then add topics
*/

$_SESSION['NewsFeeds'][] = $NewsFeeds;

if(!isset($_SESSION['NewsFeeds'])){
    $_SESSION['NewsFeeds'] = array();
    echo "<pre>";
    echo var_dump($_SESSION);
    echo "</pre>";
}else {
    $NewsFeeds[] = new NewsFeed('Midnight+Oil');
    $NewsFeeds[] = new NewsFeed('Piano');
    $NewsFeeds[] = new NewsFeed('Radiohead');
    $NewsFeeds[] = new NewsFeed('Tupac');
    $NewsFeeds[] = new NewsFeed('kittens');
    $NewsFeeds[] = new NewsFeed('gun+control');
    $NewsFeeds[] = new NewsFeed('transgender');
    $NewsFeeds[] = new NewsFeed('Mars');
    $NewsFeeds[] = new NewsFeed('linear+algebra');
    $NewsFeeds[] = new NewsFeed('California+Science+Center');
}

class NewsFeed
{
    //public $Name = "";
    public $topic = "";
    public $feedID = "";
    public $title = "";
    public $data = "";
    public $date = "";
    
    public function __construct(/*$feedID, $title, $data, $date, */ $topic){
        //$this->Name = $Name;
        $this->Link = $topic;
    }
}

  $topic = $NewsFeeds[0]->topic; 

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