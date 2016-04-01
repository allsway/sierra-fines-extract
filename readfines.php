<?php


/*
	Calulates the check digit for items and patrons from a fines files (Sierra Postgres)
	Where 'allfines.csv' is the name of your fines csv file,
	run 'php readfines.php allfines.csv > newfines.csv' to create the updated fines file. 

	
*/

function getcheckdigit($recnum) {
		$seq = array_reverse(str_split($recnum));
		$sum = 0;
		$multiplier = 2;
		
		foreach ($seq as $digit)
		{
			$digit *= $multiplier;
			$sum += $digit;
			$multiplier++;
		}
		$check = $sum % 11;
		
		if ($check == 10)
		{
		    return 'x';
		}
		else
		{
    		return strval($check);
    	}
}

$patronrec = "";
$itemerc = "";
$checkdigit = "";
$inputfile = $argv[1];
$handle = fopen($inputfile, "r");


if ($handle) {
    while (($line = fgets($handle)) !== false) 
    {
       $parts = explode(",", $line);
       $patronrec = trim($parts[0],'"');
       $itemrec=trim($parts[1],'"');
       
       // Process patron record check digit
	if(strlen($patronrec)>2 && $patronrec != "RECORD #(PATRON)")
	{     
		$checkdigit = getcheckdigit($patronrec);
       	}
       	else
       	{
       		$checkdigit = '';
       	}
       	$patronrec = '"' .$patronrec . $checkdigit . '"';
       
       	// Process item record check digit
       	//i1460254 to 4
       	if(strlen($itemrec)>0 && $itemrec != "RECORD #(ITEM)")
	{      
       		$checkdigit = getcheckdigit($itemrec);
       	}
       	else
       	{
       		$checkdigit = '';
       	}
       	$itemrec = '"' . $itemrec . $checkdigit . '"';
	$parts[0] = $patronrec;
	$parts[1] = $itemrec;
	$finalcsv = implode($parts,",");
 	echo $finalcsv;
    }

    fclose($handle);
} else {
   echo "Problem opening the file";
} 

?>
