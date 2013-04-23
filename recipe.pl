#!/usr/bin/perl

######  Tim Gray - April 21, 2010

use Tk;
use DBI;
use Date::Manip;
use Tk::DialogBox;
use Tk::ErrorDialog;
use  Tk::HList;
use  Tk::BrowseEntry;
use Tk::LabFrame;



$database =  "????";
$user = "????";
$pass = "????";
$host = "localhost";
$message = "Recipe";
$ycorr = 130;
$xcorr = 40;


# Main Window
my $mw = new MainWindow;
$mw->geometry("560x510");
$mw->title("Recipe Sheet");






my $rframe = $mw->LabFrame(
    -label => "Recipe",
    -labelside => 'acrosstop',
    -width => 110,
    -height => 50,
    )->place(-x=>10,-y=>40);

$lrblank1 = $rframe -> Label(-text => ""); 
$lrblank2 = $rframe -> Label(-text => ""); 
$lrblank3 = $rframe -> Label(-text => ""); 
$lrblank4 = $rframe -> Label(-text => ""); 
$lrblank5 = $rframe -> Label(-text => ""); 
$lrblank6 = $rframe -> Label(-text => ""); 

my $lrecipe = $rframe -> Label(-text => "Recipe:"); 
my $lnumber = $rframe -> Label(-text => "Index:"); 
my $ldate = $rframe -> Label(-text => "Date:"); 
my $ltime = $rframe -> Label(-text => "Time:"); 
my $ltank_temp = $rframe -> Label(-text => "Batch Temp:"); 
my $lpressure1 = $rframe -> Label(-text => "Pressure:"); 
my $loutlet_temp = $rframe -> Label(-text => "Outlet Temp:"); 

my $lai1 = $rframe -> Label(-text => "Ingredient 1:"); 
my $lai2 = $rframe -> Label(-text => "Ingredient 2:"); 
my $lai3 = $rframe -> Label(-text => "Ingredient 3:"); 
my $lai4 = $rframe -> Label(-text => "Ingredient 4:"); 
my $lai5 = $rframe -> Label(-text => "Ingredient 5:"); 
my $lai6 = $rframe -> Label(-text => "Ingredient 6:"); 
my $lai7 = $rframe -> Label(-text => "Ingredient 7:"); 
my $lai8 = $rframe -> Label(-text => "Ingredient 8:"); 
my $lai9 = $rframe -> Label(-text => "Ingredient 9:"); 
my $lai10 = $rframe -> Label(-text => "Ingredient 10:"); 

my $lload1 = $rframe -> Label(-text => "Percent:"); 
my $lload2 = $rframe -> Label(-text => "Percent:"); 
my $lload3 = $rframe -> Label(-text => "Percent:"); 
my $lload4 = $rframe -> Label(-text => "Percent:"); 
my $lload5 = $rframe -> Label(-text => "Percent:"); 
my $lload6 = $rframe -> Label(-text => "Percent:"); 
my $lload7 = $rframe -> Label(-text => "Percent:"); 
my $lload8 = $rframe -> Label(-text => "Percent:"); 
my $lload9 = $rframe -> Label(-text => "Percent:"); 
my $lload10 = $rframe -> Label(-text => "Percent:"); 

my $ltime1 = $rframe -> Label(-text => "Time:"); 
my $ltime2 = $rframe -> Label(-text => "Time:"); 
my $ltime3 = $rframe -> Label(-text => "Time:"); 
my $ltime4 = $rframe -> Label(-text => "Time:"); 
my $ltime5 = $rframe -> Label(-text => "Time:"); 
my $ltime6 = $rframe -> Label(-text => "Time:"); 
my $ltime7 = $rframe -> Label(-text => "Time:"); 
my $ltime8 = $rframe -> Label(-text => "Time:"); 
my $ltime9 = $rframe -> Label(-text => "Time:"); 
my $ltime10 = $rframe -> Label(-text => "Time:"); 

my $ltotal = $rframe -> Label(-text => "Total:"); 

my $enumber = $rframe -> Entry(-background => 'white', ,-foreground => 'black', -disabledforeground => 'black', -textvariable => \$rnumber, -state=>'disabled');
my $erecipe = $rframe -> Entry(-background => 'yellow', -foreground => 'black', -textvariable => \$rrecipe);
my $edate = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rdate);
my $etime = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rtime);
my $etank_temp = $rframe -> Entry(-background => 'white', -foreground => 'black', -textvariable => \$rtank_temp);
my $epressure1 = $rframe -> Entry(-background => 'white',  -width => '10',-foreground => 'black', -textvariable => \$rpressure1);
my $eoutlet_temp = $rframe -> Entry(-background => 'white',  -width => '10',-foreground => 'black', -textvariable => \$routlet_temp);

my $eai1 = $rframe -> Entry(-background => 'white', -foreground => 'black', -textvariable => \$rai1);
my $eai2 = $rframe -> Entry(-background => 'white', -foreground => 'black', -textvariable => \$rai2);
my $eai3 = $rframe -> Entry(-background => 'white', -foreground => 'black', -textvariable => \$rai3);
my $eai4 = $rframe -> Entry(-background => 'white', -foreground => 'black', -textvariable => \$rai4);
my $eai5 = $rframe -> Entry(-background => 'white', -foreground => 'black', -textvariable => \$rai5);
my $eai6 = $rframe -> Entry(-background => 'white', -foreground => 'black', -textvariable => \$rai6);
my $eai7 = $rframe -> Entry(-background => 'white', -foreground => 'black', -textvariable => \$rai7);
my $eai8 = $rframe -> Entry(-background => 'white', -foreground => 'black', -textvariable => \$rai8);
my $eai9 = $rframe -> Entry(-background => 'white', -foreground => 'black', -textvariable => \$rai9);
my $eai10 = $rframe -> Entry(-background => 'white', -foreground => 'black', -textvariable => \$rai10);

my $eload1 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rload1);
my $eload2 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rload2);
my $eload3 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rload3);
my $eload4 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rload4);
my $eload5 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rload5);
my $eload6 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rload6);
my $eload7 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rload7);
my $eload8 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rload8);
my $eload9 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rload9);
my $eload10 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rload10);

my $etime1 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rtime1);
my $etime2 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rtime2);
my $etime3 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rtime3);
my $etime4 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rtime4);
my $etime5 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black',- textvariable => \$rtime5);
my $etime6 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rtime6);
my $etime7 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rtime7);
my $etime8 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rtime8);
my $etime9 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rtime9);
my $etime10 = $rframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$rtime10);


my $etotal = $rframe -> Entry(-disabledbackground => 'green', -width => '10', -disabledforeground => 'black', -textvariable => \$rtotal, -state=>'disabled');

my $load_recipe = $mw -> Button(-text => "Select",-command =>\&select_recipe)->pack(-side=>'left',-anchor => 'n');;
my $save_recipe = $mw -> Button(-text => "Save",-command =>\&save_recipe)->pack(-side=>'left',-anchor => 'n');;
my $new_recipe = $mw -> Button(-text => "New",-command =>\&new_recipe)->pack(-side=>'left',-anchor => 'n');;
my $update_recipe = $mw -> Button(-text => "Update",-command =>\&update_recipe)->pack(-side=>'left',-anchor => 'n');;
my $delete_ask = $mw -> Button(-text => "Delete",-command =>\&delete_ask)->pack(-side=>'left',-anchor => 'n');;

$lrblank2 -> grid ();
$lrblank3 -> grid ();

$lrecipe -> grid($erecipe);
$lnumber ->grid($enumber,$ldate,$edate,$ltime,$etime);
$ltank_temp -> grid($etank_temp,$lpressure1,$epressure1,$loutlet_temp,$eoutlet_temp);

$lrblank4 -> grid ();
$lrblank5 -> grid ();

$lai1 -> grid($eai1,$lload1,$eload1,$ltime1,$etime1);
$lai2 -> grid($eai2,$lload2,$eload2,$ltime2,$etime2);
$lai3 -> grid($eai3,$lload3,$eload3,$ltime3,$etime3);
$lai4 -> grid($eai4,$lload4,$eload4,$ltime4,$etime4);
$lai5 -> grid($eai5,$lload5,$eload5,$ltime5,$etime5);
$lai6 -> grid($eai6,$lload6,$eload6,$ltime6,$etime6);
$lai7 -> grid($eai7,$lload7,$eload7,$ltime7,$etime7);
$lai8 -> grid($eai8,$lload8,$eload8,$ltime8,$etime8);
$lai9 -> grid($eai9,$lload9,$eload9,$ltime9,$etime9);
$lai10 -> grid($eai10,$lload10,$eload10,$ltime10,$etime10);
$lrblank6 -> grid('x',$ltotal,$etotal);

$mw->bind('<KeyPress>' =>\&calc);



MainLoop;

sub new_recipe {
    
    
    $rrecipe  =  ""; 
    $rdate  =  &UnixDate("today","%Y-%m-%d");
    $rtime  =  &UnixDate("today","%H:%M");
    $rtank_temp  =  0;
    $rpressure1  =  0;
    $routlet_temp  =  0;
    $rai1  =  "";
    $rai2  =   "";
    $rai3  =   "";
    $rai4  =   "";
    $rai5  =   "";
    $rai6  =   "";
    $rai7  =   "";
    $rai8  =   "";
    $rai9  =   "";
    $rai10  =  "";
    $rload1  =  0;
    $rload2  =   0;
    $rload3  =   0;
    $rload4  =   0;
    $rload5  =   0;
    $rload6  =   0;
    $rload7  =   0;
    $rload8  =   0;
    $rload9  =   0;
    $rload10  =  0;
    $rtime1  =   0;
    $rtime2  =   0;
    $rtime3  =   0;
    $rtime4  =   0;
    $rtime5  =   0;
    $rtime6  =   0;
    $rtime7  =   0;
    $rtime8  =   0;
    $rtime9  =   0;
    $rtime10  =   0;
    

}


sub delete_recipe {
    
    $subwin3->destroy;
    
    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
  		   $user, $pass,
			   {'RaiseError' => 1});
    
    my $statement =  "DELETE FROM recipe WHERE recipe = '" . $rrecipe . "'";


   #prepare and execute the statement
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute(); 
    
    if ($rows == 1){
	$mw->messageBox(-message => "Recipe succssfully deleted.\n", -type => "ok");	
    }

    if ($rows == 0){
	$mw->messageBox(-message => "Recipe delete failed !!!\n", -type => "ok");	
    }

     if ($rows == 'undef'){
	$mw->messageBox(-message => "Delete Error !!.\n", -type => "ok");	
    }
    
} 


sub delete_ask {
        
    
    if(! Exists($subwin3)){
	
	$subwin3 = $mw->Toplevel;
	$subwin3->geometry("300x150+600+400");
	$subwin3->title("Delete Batch");
	my $label  =  $subwin3 -> Label(-text => "Are you sure you want \n  to delete recipe \n " . $rrecipe . "", -font => "{Arial} 14" )->pack(); 
	my $subwin_button1 = $subwin3->Button(-text => "Yes", -font => "{Arial} 14", -command => \&delete_recipe)->pack();
	my $subwin_button2 = $subwin3->Button(-text => "No", -font => "{Arial} 14", -command => [$subwin3 => 'destroy'])->pack();
	
    }
    
    else {
	$subwin3->deiconify();
	$subwin3->raise();
	
    }
    
}


#Load Recipe 
sub load_recipe {

    $subwin1->destroy;
    
    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			   $user, $pass,
			   {'RaiseError' => 1});
    
    chomp($recipe);

    my $statement =  "SELECT number, recipe,  date,  time, tank_temp, pressure1, outlet_temp,  ai1,  ai2,  ai3, ai4, ai5, ai6, ai7, ai8, ai9, ai10, load1, load2, load3, load4, load5, load6, load7, load8, load9, load10, time1, time2, time3, time4, time5, time6, time7, time8, time9, time10 FROM recipe WHERE recipe = '"  .  $recipe . "'";

    #print $statement;
    
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute();
    my $results = $sth->fetchrow_hashref;
    
    $rnumber  =  $results->{number};
    $rrecipe  =  $results->{recipe};
    $rdate  =  $results->{date};
    $rtime  =  $results->{time};
    $rtank_temp  =  $results->{tank_temp};
    $rpressure1  =  $results->{pressure1};
    $routlet_temp  =  $results->{outlet_temp};
    $rai1  =  $results->{ai1};
    $rai2  =  $results->{ai2};
    $rai3  =  $results->{ai3};
    $rai4  =  $results->{ai4};
    $rai5  =  $results->{ai5};
    $rai6  =  $results->{ai6};
    $rai7  =  $results->{ai7};
    $rai8  =  $results->{ai8};
    $rai9  =  $results->{ai9};
    $rai10  =  $results->{ai10};
    $rload1  =  $results->{load1};
    $rload2  =  $results->{load2};
    $rload3  =  $results->{load3};
    $rload4  =  $results->{load4};
    $rload5  =  $results->{load5};
    $rload6  =  $results->{load6};
    $rload7  =  $results->{load7};
    $rload8  =  $results->{load8};
    $rload9  =  $results->{load9};
    $rload10  =  $results->{load10};
    $rtime1  =  $results->{time1};
    $rtime2  =  $results->{time2};
    $rtime3  =  $results->{time3};
    $rtime4  =  $results->{time4};
    $rtime5  =  $results->{time5};
    $rtime6  =  $results->{time6};
    $rtime7  =  $results->{time7};
    $rtime8  =  $results->{time8};
    $rtime9  =  $results->{time9};
    $rtime10  =  $results->{time10};
    
    &calc;
    
    if ($rows == 1){
	$mw->messageBox(-message => "Recipe succssfully loaded.\n", -type => "ok");	
    }
    
    if ($rows == 0){
	$mw->messageBox(-message => "Recipe load failed !!!\n", -type => "ok");
	
    }
    
    if ($rows == 'undef'){
	$mw->messageBox(-message => "Load Error !!.\n", -type => "ok");	
    }
    
    
  
    
}


sub update_recipe {


    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			   $user, $pass,
			   {'RaiseError' => 1});
     
    #create the update statement
    my $statement =  "UPDATE recipe SET " . 

"date = " .  "'" .  $rdate . "', " .
"time =" . "'" . $rtime . "', " .
"ai1 =" . "'" . $rai1 . "', " .
"ai2 =" . "'" .  $rai2 . "', " .
"ai3 =" . "'" .  $rai3 . "', " .
"ai4 =" . "'" . $rai4 . "', " .
"ai5=" . "'" .  $rai5 . "', " .
"ai6 =" . "'" . $rai6 . "', " .	 
"ai7 =" . "'" . $rai7 . "', " . 
"ai8 = " . "'" . $rai8 . "', " . 
"ai9 =" . "'" . $rai9 . "', " .	
"ai10 =" . "'" . $rai10 . "', " .
"load1 =" . $rload1 . ", " . 
"load2 =" . $rload2 . ", " . 
"load3 =" . $rload3 . ", " .
"load4 =" . $rload4 . ", " . 
"load5 =" . $rload5 . ", " . 
"load6 =" . $rload6 . ", " . 
"load7 =" . $rload7 . ", " . 
"load8 =" . $rload8 . ", " . 
"load9 =" . $rload9 . ", " . 
"load10 =" . $rload10 . ", " . 
"tank_temp =" . $rtank_temp . ", " . 
"pressure1 =" . $rpressure1 . ", " . 
"outlet_temp =" . $routlet_temp . ", " .
"time1 =" . $rtime1 . ", " . 
"time2 =" . $rtime2 . ", " . 
"time3 =" . $rtime3 . ", " . 
"time4 =" . $rtime4 . ", " . 
"time5 =" . $rtime5 . ", " . 
"time6 =" . $rtime6 . ", " . 
"time7 =" . $rtime7 . ", " . 
"time8 =" . $rtime8 . ", " . 
"time9 =" . $rtime9 . ", " . 
"time10 =" . $rtime10 . " " . 

"WHERE recipe =" . "'" . $rrecipe . "'" ;


    #prepare and execute the statement
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute(); 
    
    if ($rows == 1){
	$mw->messageBox(-message => "Recipe succssfully updated.\n", -type => "ok");	
    }

    if ($rows == 0){
	$mw->messageBox(-message => "Recipe update failed !!!\n", -type => "ok");	
    }

     if ($rows == 'undef'){
	$mw->messageBox(-message => "Update Error !!.\n", -type => "ok");	
    }

   
}






# Save a new Recipe
sub save_recipe {


    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			   $user, $pass,
			   {'RaiseError' => 1});
    
    #Check for duplicate recipe
    my $check_duplicate = ("SELECT recipe FROM recipe WHERE recipe = '" .  $rrecipe . "'");
    my $check = $dbh->prepare($check_duplicate);
    $check->execute(); 
    
    #if duplicate show message and die
    my $matches =$check->rows;
    if ($matches >= 1) {
	$mw->messageBox(-message => "Duplicate recipe. Cannot save!", -type => "ok");
	die;
    };


      if ($rrecipe eq ""){
	$mw->messageBox(-message => "Bad recipe name. Cannot save!", -type => "ok");
	die;
    }


     
    #create the insert statement
    my $statement =  "INSERT INTO recipe \(recipe, date, time,  ai1,  ai2,  ai3, ai4, ai5, ai6, ai7, ai8, ai9, ai10, load1, load2, load3, load4, load5, load6, load7, load8, load9, load10, tank_temp, pressure1, outlet_temp, time1, time2, time3, time4, time5, time6, time7, time8, time9, time10 \) VALUES \('" .  $rrecipe . "','" .   $rdate . "','" .   $rtime . "','" .   $rai1 . "','" .   $rai2 . "','" .   $rai3 . "','" .  $rai4 . "','" .  $rai5 . "','" .  $rai6 . "','" .  $rai7 . "','" .  $rai8 . "','" .  $rai9 . "','" .  $rai10 . "'," .  $rload1 . "," .  $rload2 . "," .  $rload3 . "," .  $rload4 . "," .  $rload5 . "," .  $rload6 . "," .  $rload7 . "," .  $rload8 . "," .  $rload9 . "," .  $rload10 . ","  .  $rtank_temp . "," .  $rpressure1 . "," .  $routlet_temp . "," .  $rtime1 . "," .  $rtime2 . "," .  $rtime3 . "," .  $rtime4 . "," .  $rtime5 . "," .  $rtime6 . "," .  $rtime7 . "," .  $rtime8 . "," .  $rtime9 . "," .  $rtime10 . "\)" ;
    
    #prepare and execute the statement
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute(); 
 
    if ($rows == 1){
	$mw->messageBox(-message => "Recipe succssfully saved.\n", -type => "ok");	
    }
    
    if ($rows == 0){
	$mw->messageBox(-message => "Recipe save failed !!!\n", -type => "ok");	
    }

     if ($rows == 'undef'){
	$mw->messageBox(-message => "Save Error !!.\n", -type => "ok");	
    }

      
}




sub calc {

   $rtotal =  $rload1 +  $rload2 +  $rload3 + $rload4 + $rload5 + $rload6 +  $rload7 +  $rload8 +  $rload9  + $rload10;
   
}


sub select_recipe {
    
    $recipe = "";
        
    if(! Exists($subwin1)){
	
	$subwin1 = $mw->Toplevel;
	$subwin1->geometry("300x150+100+100");
	$subwin1->title("Recipe Select");
	my $subwin_button = $subwin1->Button(-text => "Load Recipe",
					     -command => \&load_recipe)->pack();
	
	my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			       $user, $pass,
			       {'RaiseError' => 1});
	
	my $statement =  "SELECT recipe  FROM  recipe";
	my $sth = $dbh->prepare($statement);
	$sth->execute(); 
	
	my $index=0;
	my @array;
	while ($results = $sth->fetchrow()) {
	    $array[$index] = $results;
	    $index++;
	    
    }
	my $lst = $subwin1->Scrolled('Listbox',-scrollbars => 'osow',-selectmode => 'single')->pack;	
	$lst -> insert('end', @array);
	
	
	
### This run when item is list is selected and get the value.
	$lst->bind('<<ListboxSelect>>',
		   sub {
		       my @sel = $lst->curselection();
		       $recipe =  $array[$sel[0]] . "\n";
		   } );
	
    }	
    
    else {
	$subwin1->deiconify();
	$subwin1->raise();
	
    }
}



