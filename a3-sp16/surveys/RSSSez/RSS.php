<?php
//RSS.php
namespace RSSSez;

/**
 * Survey Class retrieves data info for an individual Survey
 * 
 * The constructor an instance of the Survey class creates multiple instances of the 
 * Question class and the Answer class to store questions & answers data from the DB.
 *
 * Properties of the Survey class like Title, Description and TotalQuestions provide 
 * summary information upon demand.
 * 
 * A survey object (an instance of the Survey class) can be created in this manner:
 *
 *<code>
 *$mySurvey = new SurveySez\Survey(1);
 *</code>
 *
 * In which one is the number of a valid Survey in the database. 
 *
 * The forward slash in front of IDB picks up the global namespace, which is required 
 * now that we're here inside the SurveySez namespace: \IDB::conn()
 *
 * The showQuestions() method of the Survey object created will access an array of question 
 * objects and internally access a method of the Question class named showAnswers() which will 
 * access an array of Answer objects to produce the visible data.
 *
 * @see Question
 * @see Answer 
 * @todo none
 */
 
class RSS
{
	 public $CategoryID = 0;
	 public $Description = "";
	 public $URL = "";
	 public $isValid = FALSE;
	 public $TotalQuestions = 0; #stores number of questions
	 protected $aQuestion = Array();#stores an array of question objects
	
	/**
	 * Constructor for Survey class. 
	 *
	 * @param integer $id The unique ID number of the Survey
	 * @return void 
	 * @todo none
	 */ 
    function __construct($id)
	{#constructor sets stage by adding data to an instance of the object
		$this->CategoryID = (int)$id;
		if($this->CategoryID == 0){return FALSE;}
		
		#get Survey data from DB
		$sql = sprintf("select Description, URL from " . PREFIX . "rssfeed_Categories Where CategoryID = %d", $this->CategoryID);
		
		#in mysqli, connection and query are reversed!  connection comes first
		$result = mysqli_query(\IDB::conn(),$sql) or die(trigger_error(mysqli_error(\IDB::conn()), E_USER_ERROR));
		if (mysqli_num_rows($result) > 0)
		{#Must be a valid survey!
			$this->isValid = TRUE;
			while ($row = mysqli_fetch_assoc($result))
			{#dbOut() function is a 'wrapper' designed to strip slashes, etc. of data leaving db
			     $this->Description = dbOut($row['Description']);
			     $this->URL = dbOut($row['URL']);
			}
		}
		@mysqli_free_result($result); #free resources
		
		if(!$this->isValid){return;}  #exit, as Survey is not valid
		
        
        
		#attempt to create question objects
		$sql = sprintf("select EntertainmentID, Title, FeedURL from " . PREFIX . "rssfeed_Entertainment where CategoryID =%d", $this->CategoryID); // Original: CategoryID =%d. 
		$result = mysqli_query(\IDB::conn(),$sql) or die(trigger_error(mysqli_error(\IDB::conn()), E_USER_ERROR));
		if (mysqli_num_rows($result) > 0)
		{#show results
		   while ($row = mysqli_fetch_assoc($result))
		   {
				#create question, and push onto stack!
				$this->aQuestion[] = new Question(dbOut($row['EntertainmentID']),dbOut($row['Title']),dbOut($row['FeedURL'])); 
		   }
		} else { 
        
            echo "No RSS feeds found"; 
        
        }
		$this->TotalQuestions = count($this->aQuestion); //the count of the aQuestion array is the total number of questions
		@mysqli_free_result($result); #free resources
		
        
        /*
		#attempt to load all Answer objects into cooresponding Question objects 
	    $sql = "select a.AnswerID, a.Answer, a.Description, a.QuestionID from  
		" . PREFIX . "surveys s inner join " . PREFIX . "questions q on q.SurveyID=s.SurveyID 
		inner join " . PREFIX . "answers a on a.QuestionID=q.QuestionID   
		where s.SurveyID = %d   
		order by a.AnswerID asc";
		$sql = sprintf($sql,$this->CategoryID); #process SQL
		$result = mysqli_query(\IDB::conn(),$sql) or die(trigger_error(mysqli_error(\IDB::conn()), E_USER_ERROR));
		if (mysqli_num_rows($result) > 0)
		{#at least one answer!
		   while ($row = mysqli_fetch_assoc($result))
		   {#match answers to questions
			    $QuestionID = (int)$row['QuestionID']; #process db var
				foreach($this->aQuestion as $question)
				{#Check db questionID against Question Object ID
					if($question->QuestionID == $QuestionID)
					{
						$question->TotalAnswers += 1;  #increment total number of answers
						#create answer, and push onto stack!
						$question->aAnswer[] = new Answer((int)$row['AnswerID'],dbOut($row['Answer']),dbOut($row['Description']));
						break; 
					}
				}	
		   }
		}
        
         */ 
        
	}# end Survey() constructor
	
	/**
	 * Reveals questions in internal Array of Question Objects 
	 *
	 * @param none
	 * @return string prints data from Question Array 
	 * @todo none
	 */ 
        
        
        
    function showQuestions()
       
    {
		if($this->TotalQuestions > 0)
		{#be certain there are questions
			foreach($this->aQuestion as $question)
			{#print data for each 
				echo $question->EntertainmentID . " ";
				echo $question->Title . " ";
				echo $question->FeedURL . "<br />";
                
                // echo $question-><"a href=" . FeedURL . "</a><br />";
                
                
				#call showAnswers() method to display array of Answer objects
				// $question->showAnswers() . "<br />";
			}
		}else{
			echo "There are currently no questions for this survey.";	
		}
	}# end showQuestions() method
    
    
    
}# end Survey class