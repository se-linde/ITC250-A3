<?php
// xml-test.php

// This is where the XML file is found locally. 
$file = 'xml/contacts.xml'; 

$xml = simplexml_load_file($file); 

// Commenting out the var-dump. 
// echo '<pre>'; 
// var_dump($xml);
// echo '</pre>';


// This is how to get data from the different elements inside the 
// container. 

foreach($xml as $contact) 
{
    echo $contact->FirstLast . '<br />'; 
    echo $contact->CityStateZip . '<br />';
    echo $contact->Phone . '<br />';
    
    // This is how to get data from the attributes. 
    // attributes() is a method. Object w/ a method w/ a property.  
    echo $contact->attributes()->ID . '<br />';
    
}



