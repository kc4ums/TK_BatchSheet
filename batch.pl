#!/usr/bin/perl
use Tk;
use DBI;
use Date::Manip;
use Tk::DialogBox;
use Tk::ErrorDialog;
use  Tk::HList;
use  Tk::BrowseEntry;
use  Tk::LabFrame;
use Tk::DateEntry;

$database =  "????";
$user = "????";
$pass = "????";
$host = "localhost";
$message = "Quality Control Certification";
$ycorr = 130;
$xcorr = 40;

$vdate = &UnixDate("today","%Y-%m-%d");
$vtime = &UnixDate("today","%H:%M");

# Main Window
my $mw = new MainWindow;
$mw->geometry("1130x465");
$mw->title("Batch Sheet");




my $rframe = $mw->LabFrame(
    -label => "Recipe",
    -labelside => 'acrosstop',
    -width => 110,
    -height => 50,
    )->place(-x=>10,-y=>10);

my $bframe = $mw->LabFrame(
    -label => "Batch",
    -labelside => 'acrosstop',
    -width => 110,
    -height => 50,
    )->place(-x=>600,-y=>10);


#### INSIDE OF RECIPE FRAME
my $select_recipe = $rframe -> Button(-text => "Select",-command =>\&select_recipe);

$lrnumber = $rframe -> Label(-text => "Index:"); 
$lrrecipe = $rframe -> Label(-text => "Recipe:"); 
$lrdate = $rframe -> Label(-text => "Recipe Date:"); 
$lrtime = $rframe -> Label(-text => "Recipe Time:"); 
$lrtank_temp = $rframe -> Label(-text => "Tank Temp:"); 
$lrpressure1 = $rframe -> Label(-text => "Pressure:"); 
$lroutlet_temp = $rframe -> Label(-text => "Outlet Temp:"); 

$lrblank1 = $rframe -> Label(-text => ""); 
$lrblank2 = $rframe -> Label(-text => ""); 

$lrai1 = $rframe -> Label(-text => "Ingredient 1:"); 
$lrai2 = $rframe -> Label(-text => "Ingredient 2:");
$lrai3 = $rframe -> Label(-text => "Ingredient 3:"); 
$lrai4 = $rframe -> Label(-text => "Ingredient 4:"); 
$lrai5 = $rframe -> Label(-text => "Ingredient 5:"); 
$lrai6 = $rframe -> Label(-text => "Ingredient 6:"); 
$lrai7 = $rframe -> Label(-text => "Ingredient 7:"); 
$lrai8 = $rframe -> Label(-text => "Ingredient 8:"); 
$lrai9 = $rframe -> Label(-text => "Ingredient 9:"); 
$lrai10 = $rframe -> Label(-text => "Ingredient 10:");

$ernumber = $rframe -> Entry(-disabledbackground => 'gray', -width => '20', -disabledforeground => 'black', -textvariable => \$rnumber, -state=>'disabled');
$errecipe = $rframe -> Entry(-disabledbackground => 'gray', -width => '20', -disabledforeground => 'black', -textvariable => \$rrecipe, -state=>'disabled');
$erdate = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rdate, -state=>'disabled');
$ertime = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime, -state=>'disabled');
$ertank_temp = $rframe -> Entry(-disabledbackground => 'gray', -width => '20', -disabledforeground => 'black', -textvariable => \$rtank_temp, -state=>'disabled');
$erpressure1 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rpressure1, -state=>'disabled');
$eroutlet_temp = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$routlet_temp, -state=>'disabled');

$erai1 = $rframe -> Entry(-disabledbackground => 'gray', -width => '20', -disabledforeground => 'black', -textvariable => \$rai1, -state=>'disabled');
$erai2 = $rframe -> Entry(-disabledbackground => 'gray', -width => '20',-disabledforeground => 'black',-textvariable => \$rai2, -state=>'disabled');
$erai3 = $rframe -> Entry(-disabledbackground => 'gray', -width => '20',-disabledforeground => 'black',-textvariable => \$rai3, -state=>'disabled');
$erai4 = $rframe -> Entry(-disabledbackground => 'gray', -width => '20',-disabledforeground => 'black',-textvariable => \$rai4, -state=>'disabled');
$erai5 = $rframe -> Entry(-disabledbackground => 'gray', -width => '20',-disabledforeground => 'black',-textvariable => \$rai5, -state=>'disabled');
$erai6 = $rframe -> Entry(-disabledbackground => 'gray', -width => '20',-disabledforeground => 'black',-textvariable => \$rai6, -state=>'disabled');
$erai7 = $rframe -> Entry(-disabledbackground => 'gray', -width => '20',-disabledforeground => 'black',-textvariable => \$rai7, -state=>'disabled');
$erai8 = $rframe -> Entry(-disabledbackground => 'gray', -width => '20',-disabledforeground => 'black',-textvariable => \$rai8, -state=>'disabled');
$erai9 = $rframe -> Entry(-disabledbackground => 'gray', -width => '20',-disabledforeground => 'black',-textvariable => \$rai9, -state=>'disabled');
$erai10 = $rframe -> Entry(-disabledbackground => 'gray', -width => '20',-disabledforeground => 'black',-textvariable => \$rai10, -state=>'disabled');

$lrpercent1 = $rframe -> Label(-text => "Percent 1:"); 
$lrpercent2 = $rframe -> Label(-text => "Percent 2:"); 
$lrpercent3 = $rframe -> Label(-text => "Percent 3:"); 
$lrpercent4 = $rframe -> Label(-text => "Percent 4:"); 
$lrpercent5 = $rframe -> Label(-text => "Percent 5:"); 
$lrpercent6 = $rframe -> Label(-text => "Percent 6:"); 
$lrpercent7 = $rframe -> Label(-text => "Percent 7:"); 
$lrpercent8 = $rframe -> Label(-text => "Percent 8:"); 
$lrpercent9 = $rframe -> Label(-text => "Percent 9:"); 
$lrpercent10 = $rframe -> Label(-text => "Percent 10:"); 
$lrpercent_total = $rframe -> Label(-text => "Percent Total:"); 


$erpercent1 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rpercent1, -state=>'disabled');
$erpercent2 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rpercent2, -state=>'disabled');
$erpercent3 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rpercent3, -state=>'disabled');
$erpercent4 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rpercent4, -state=>'disabled');
$erpercent5 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rpercent5, -state=>'disabled');
$erpercent6 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rpercent6, -state=>'disabled');
$erpercent7 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rpercent7, -state=>'disabled');
$erpercent8 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rpercent8, -state=>'disabled');
$erpercent9 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rpercent9, -state=>'disabled');
$erpercent10 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rpercent10, -state=>'disabled');
$erpercent_total = $rframe -> Entry(-disabledbackground => 'green', -width => '10', -disabledforeground => 'black', -textvariable => \$rpercent_total, -state=>'disabled');

$lrtime1 = $rframe -> Label(-text => "Time 1:"); 
$lrtime2 = $rframe -> Label(-text => "Time 2:"); 
$lrtime3 = $rframe -> Label(-text => "Time 3:"); 
$lrtime4 = $rframe -> Label(-text => "Time 4:"); 
$lrtime5 = $rframe -> Label(-text => "Time 5:"); 
$lrtime6 = $rframe -> Label(-text => "Time 6:"); 
$lrtime7 = $rframe -> Label(-text => "Time 7:"); 
$lrtime8 = $rframe -> Label(-text => "Time 8:"); 
$lrtime9 = $rframe -> Label(-text => "Time 9:"); 
$lrtime10 = $rframe -> Label(-text => "Time 10:"); 
$lrtime_total = $rframe -> Label(-text => "Time Total:"); 

$ertime1 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime1, -state=>'disabled');
$ertime2 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime2, -state=>'disabled');
$ertime3 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime3, -state=>'disabled');
$ertime4 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime4, -state=>'disabled');
$ertime5 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime5, -state=>'disabled');
$ertime6 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime6, -state=>'disabled');
$ertime7 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime7, -state=>'disabled');
$ertime8 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime8, -state=>'disabled');
$ertime9 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime9, -state=>'disabled');
$ertime10 = $rframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime10, -state=>'disabled');
$ertime_total = $rframe -> Entry(-disabledbackground => 'green', -width => '10', -disabledforeground => 'black', -textvariable => \$rtime_total,-state=>'disabled');

$select_recipe -> grid();
$lrrecipe -> grid ($errecipe);
$lrnumber -> grid ($ernumber,$lrdate,$erdate,$lrtime,$ertime);
$lrtank_temp -> grid ($ertank_temp, $lrpressure1, $erpressure1, $lroutlet_temp, $eroutlet_temp);

$lrblank1 -> grid ();
$lrblank2 -> grid ();

$lrai1->grid($erai1,$lrpercent1,$erpercent1,$lrtime1,$ertime1);
$lrai2->grid($erai2,$lrpercent2,$erpercent2,$lrtime2,$ertime2);
$lrai3->grid($erai3,$lrpercent3,$erpercent3,$lrtime3,$ertime3);
$lrai4->grid($erai4,$lrpercent4,$erpercent4,$lrtime4,$ertime4);
$lrai5->grid($erai5,$lrpercent5,$erpercent5,$lrtime5,$ertime5);
$lrai6->grid($erai6,$lrpercent6,$erpercent6,$lrtime6,$ertime6);
$lrai7->grid($erai7,$lrpercent7,$erpercent7,$lrtime7,$ertime7);
$lrai8->grid($erai8,$lrpercent8,$erpercent8,$lrtime8,$ertime8);
$lrai9->grid($erai9,$lrpercent9,$erpercent9,$lrtime9,$ertime9);
$lrai10->grid($erai10,$lrpercent10,$erpercent10,$lrtime10,$ertime10);
$lrblank2->grid('x',$lrpercent_total,$erpercent_total,$lrtime_total,$ertime_total);

### INSIDE OF BATCH FRAME
my $select_batch = $bframe -> Button(-text => "Select",-command =>\&select_batch);
my $save_batch = $bframe -> Button(-text => "Save",-command =>\&save_batch);
my $update_batch = $bframe -> Button(-text => "Update",-command =>\&update_batch);
my $new_batch = $bframe -> Button(-text => "New Batch",-command =>\&new_batch);
my $delete_ask = $bframe -> Button(-text => "Delete",-command =>\&delete_ask);

$lboperator  =  $bframe -> Label(-text => "Operator:"); 
$lbbatch_date  =  $bframe -> Label(-text => "Batch Date:");
$lbbatch_time  =  $bframe -> Label(-text => "Batch Time:");
$lbbatch  =  $bframe -> Label(-text => "Batch:");
$lbrun_date  =  $bframe -> Label(-text => "Run Date:");
$lbrun_time  =  $bframe -> Label(-text => "Run Time:");
$lbbatch_info  =  $bframe -> Label(-text => "Batch Info:");
$lbrevise_date  =  $bframe -> Label(-text => "Revise Date:");
$lbstart_wgt  =  $bframe -> Label(-text => "Start Weight:");
$lbfrom_batch  =  $bframe -> Label(-text => "From Batch:");
$lbbatch_size  = $bframe -> Label(-text => "Batch Size:"); 

$lbblank1 = $bframe -> Label(-text => ""); 
$lbblank2 = $bframe -> Label(-text => ""); 

$lbload1 =  $bframe -> Label(-text => "Load 1:");
$lbload2 =  $bframe -> Label(-text => "Load 2:");
$lbload3 =  $bframe -> Label(-text => "Load 3:");
$lbload4 =  $bframe -> Label(-text => "Load 4:");
$lbload5 =  $bframe -> Label(-text => "Load 5:");
$lbload6 =  $bframe -> Label(-text => "Load 6:");
$lbload7 =  $bframe -> Label(-text => "Load 7:");
$lbload8 =  $bframe -> Label(-text => "Load 8:"); 
$lbload9 =  $bframe -> Label(-text => "Load 9:");
$lbload10 = $bframe -> Label(-text => "Load 10:");
$lbload_total = $bframe -> Label(-text => "Load Total:");
$lbactual1 =  $bframe -> Label(-text => "Actual 1:");
$lbactual2 =  $bframe -> Label(-text => "Actual 2:");
$lbactual3 =  $bframe -> Label(-text => "Actual 3:");
$lbactual4 =  $bframe -> Label(-text => "Actual 4:"); 
$lbactual5 =  $bframe -> Label(-text => "Actual 5:");
$lbactual6 =  $bframe -> Label(-text => "Actual 6:");
$lbactual7 =  $bframe -> Label(-text => "Actual 7:");
$lbactual8 =  $bframe -> Label(-text => "Actual 8:");
$lbactual9 =  $bframe -> Label(-text => "Actual 9:");
$lbactual10 = $bframe -> Label(-text => "Actual 10:");
$lbactual_total = $bframe -> Label(-text => "Actual Total:");
$lbadd1 =  $bframe -> Label(-text => "Additive 1:");
$lbadd2 =  $bframe -> Label(-text => "Additive 2:");
$lbadd3 =  $bframe -> Label(-text => "Additive 3:");
$lbadd4 =  $bframe -> Label(-text => "Additive 4:");
$lbadd5 =  $bframe -> Label(-text => "Additive 5:");
$lbadd6 =  $bframe -> Label(-text => "Additive 6:");
$lbadd7 =  $bframe -> Label(-text => "Additive 7:");
$lbadd8 =  $bframe -> Label(-text => "Additive 8:");
$lbadd9 =  $bframe -> Label(-text => "Additive 9:");
$lbadd10 =  $bframe -> Label(-text => "Additive 10:");
$lbadd_total =  $bframe -> Label(-text => "Additive Total:");
$ebbatch = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bbatch);

$ebbatch_date = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bbatch_date);
$ebbatch_date=$bframe->DateEntry(-weekstart=>1,-daynames=>[qw/Sun Mon Tue Wed Thu Fri Sat/],-dateformat => 4,-textvariable => \$bbatch_date,);


$ebbatch_time = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bbatch_time);
$eboperator = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$boperator);

$ebrun_date = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$brun_date);
$ebrun_date=$bframe->DateEntry(-weekstart=>1,-daynames=>[qw/Sun Mon Tue Wed Thu Fri Sat/],-dateformat => 4,-textvariable => \$brun_date,);

$ebrun_time = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$brun_time);
$ebbatch_info  = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bbatch_info);
$ebrevise_date = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$brevise_date);
$ebstart_wgt = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bstart_wgt);
$ebfrom_batch = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bfrom_batch);
$ebbatch_size = $bframe -> Entry(-background => 'orange', -width => '10', -foreground => 'black', -textvariable => \$bbatch_size);
$ebload1 = $bframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$bload1, -state=>'disabled');
$ebload2 = $bframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$bload2, -state=>'disabled');
$ebload3 = $bframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$bload3, -state=>'disabled');
$ebload4 = $bframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$bload4, -state=>'disabled');
$ebload5 = $bframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$bload5, -state=>'disabled');
$ebload6 = $bframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$bload6, -state=>'disabled');
$ebload7 = $bframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$bload7, -state=>'disabled');
$ebload8 = $bframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$bload8, -state=>'disabled');
$ebload9 = $bframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$bload9, -state=>'disabled');
$ebload10 = $bframe -> Entry(-disabledbackground => 'gray', -width => '10', -disabledforeground => 'black', -textvariable => \$bload10, -state=>'disabled');
$ebload_total = $bframe -> Entry(-disabledbackground => 'green', -width => '10', -disabledforeground => 'black', -textvariable => \$bload_total,-state=>'disabled');
$ebactual1 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bactual1);
$ebactual2 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bactual2);
$ebactual3 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bactual3);
$ebactual4 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bactual4);
$ebactual5 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bactual5);
$ebactual6 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bactual6);
$ebactual7 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bactual7);
$ebactual8 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bactual8);
$ebactual9 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bactual9);
$ebactual10 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$bactual10);
$ebactual_total = $bframe -> Entry(-disabledbackground => 'green', -width => '10', -disabledforeground => 'black', -textvariable => \$bactual_total,-state=>'disabled');
$ebadd1 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$badd1);
$ebadd2 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$badd2);
$ebadd3 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$badd3);
$ebadd4 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$badd4);
$ebadd5 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$badd5);
$ebadd6 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$badd6);
$ebadd7 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$badd7);
$ebadd8 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$badd8);
$ebadd9 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$badd9);
$ebadd10 = $bframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$badd10);
$ebadd_total = $bframe -> Entry(-disabledbackground => 'green', -width => '10', -disabledforeground => 'black', -textvariable => \$badd_total,-state=>'disabled');


$select_batch -> grid($save_batch,$update_batch,$new_batch,$delete_ask);
$lbbatch -> grid($ebbatch,$lbbatch_date,$ebbatch_date,$lbbatch_time,$ebbatch_time);
$lboperator -> grid($eboperator, $lbrun_date, $ebrun_date, $lbrun_time, $ebrun_time);
$lbbatch_info -> grid($ebbatch_info,$lbrevise_date,$ebrevise_date,'x','x');
$lbstart_wgt -> grid($ebstart_wgt,$lbfrom_batch,$ebfrom_batch,$lbbatch_size,$ebbatch_size);

$lbblank1 -> grid ();


$lbload1->grid($ebload1,$lbactual1,$ebactual1,$lbadd1,$ebadd1);
$lbload2->grid($ebload2,$lbactual2,$ebactual2,$lbadd2,$ebadd2);
$lbload3->grid($ebload3,$lbactual3,$ebactual3,$lbadd3,$ebadd3);
$lbload4->grid($ebload4,$lbactual4,$ebactual4,$lbadd4,$ebadd4);
$lbload5->grid($ebload5,$lbactual5,$ebactual5,$lbadd5,$ebadd5);
$lbload6->grid($ebload6,$lbactual6,$ebactual6,$lbadd6,$ebadd6);
$lbload7->grid($ebload7,$lbactual7,$ebactual7,$lbadd7,$ebadd7);
$lbload8->grid($ebload8,$lbactual8,$ebactual8,$lbadd8,$ebadd8);
$lbload9->grid($ebload9,$lbactual9,$ebactual9,$lbadd9,$ebadd9);
$lbload10->grid($ebload10,$lbactual10,$ebactual10,$lbadd10,$ebadd10);
$lbload_total->grid($ebload_total,$lbactual_total,$ebactual_total,$lbadd_total,$ebadd_total);


&new_batch;

#### BINDINGS

$mw->bind( '<Any-KeyPress>' => \&calc_totals); 
$ebbatch_size->bind( '<Any-KeyPress>' => \&calc_loads); 


MainLoop;


sub load_recipe {
   
    $subwin1->destroy;
    
    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
  		   $user, $pass,
			   {'RaiseError' => 1});
   
    chomp($recipe);
    
       my $statement =  "SELECT number, recipe,  date,  time,  tank_temp, pressure1, outlet_temp, ai1,  ai2,  ai3, ai4, ai5, ai6, ai7, ai8, ai9, ai10, load1, load2, load3, load4, load5, load6, load7, load8, load9, load10, time1, time2, time3, time4, time5, time6, time7, time8, time9, time10 FROM recipe WHERE recipe = '"  .  $recipe . "'";
    
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute();
    my $results = $sth->fetchrow_hashref;
    
    $rnumber  =  $results->{number};
    $rrecipe  =  $results->{recipe};
    $rdate    =  $results->{date};
    $rtime    =  $results->{time};
    $rtank_temp = $results->{tank_temp};
    $rpressure1 = $results->{pressure1};
    $routlet_temp = $results->{outlet_temp};

    $rai1 =  $results->{ai1};
    $rai2 =  $results->{ai2};
    $rai3 =  $results->{ai3};
    $rai4 =  $results->{ai4};
    $rai5 =  $results->{ai5};
    $rai6 =  $results->{ai6};
    $rai7 =  $results->{ai7};
    $rai8 =  $results->{ai8};
    $rai9 =  $results->{ai9};
    $rai10 =  $results->{ai10};
   
    $rpercent1 =  $results->{load1};
    $rpercent2 =  $results->{load2};
    $rpercent3 =  $results->{load3};
    $rpercent4 =  $results->{load4};
    $rpercent5 =  $results->{load5};
    $rpercent6 =  $results->{load6};
    $rpercent7 =  $results->{load7};
    $rpercent8 =  $results->{load8};
    $rpercent9 =  $results->{load9};
    $rpercent10 =  $results->{load10};

    $rtime1 =  $results->{time1};
    $rtime2 =  $results->{time2};
    $rtime3 =  $results->{time3};
    $rtime4 =  $results->{time4};
    $rtime5 =  $results->{time5};
    $rtime6 =  $results->{time6};
    $rtime7 =  $results->{time7};
    $rtime8 =  $results->{time8};
    $rtime9 =  $results->{time9};
    $rtime10 =  $results->{time10};

    &calc_totals; 
    &calc_loads;

              
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



sub delete_batch {
    
    $subwin3->destroy;

    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			   $user, $pass,
			   {'RaiseError' => 1});
    
    my $statement =  "DELETE FROM batch WHERE batch = '" . $bbatch . "'";


   #prepare and execute the statement
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute(); 
    
    if ($rows == 1){
	$mw->messageBox(-message => "Batch succssfully deleted.\n", -type => "ok");	
    }

    if ($rows == 0){
	$mw->messageBox(-message => "Batch delete failed !!!\n", -type => "ok");	
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
	my $label  =  $subwin3 -> Label(-text => "Are you sure you want \n  to delete batch \n " . $bbatch . "", -font => "{Arial} 14" )->pack(); 
	my $subwin_button1 = $subwin3->Button(-text => "Yes", -font => "{Arial} 14", -command => \&delete_batch)->pack();
	my $subwin_button2 = $subwin3->Button(-text => "No", -font => "{Arial} 14", -command => [$subwin3 => 'destroy'])->pack();
	
    }
    
    else {
	$subwin3->deiconify();
	$subwin3->raise();
	
    }
    
}

sub load_batch {
    
    $subwin2->destroy;
    
    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			   $user, $pass,
			   {'RaiseError' => 1});
    
    
    chomp($batch);
    
    my $statement =  "SELECT operator, batch_date, batch_time,  batch, run_date, run_time, batch_info, revise_date, start_wgt,from_batch, batch_size, load1, load2, load3, load4, load5, load6, load7, load8, load9, load10,  actual1, actual2, actual3, actual4, actual5, actual6, actual7, actual8, actual9, actual10, add1, add2, add3, add4, add5, add6, add7, add8, add9, add10, recipe_number,recipe, recipe_date, recipe_time, tank_temp, pressure1, outlet_temp, ai1, ai2, ai3, ai4, ai5, ai6, ai7, ai8, ai9, ai10, percent1, percent2, percent3, percent4, percent5, percent6, percent7, percent8, percent9, percent10, time1, time2, time3, time4, time5, time6, time7, time8, time9, time10 FROM batch WHERE batch = '"  .  $batch . "'";
    
    
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute();
    my $results = $sth->fetchrow_hashref;
   

#### BATCH ITEMS 
    $boperator  =  $results->{operator};
    $bbatch_date  =  $results->{batch_date};
    $bbatch_time  =  $results->{batch_time};
    $bbatch  =  $results->{batch};
    $brun_date  =  $results->{run_date};
    $brun_time  =  $results->{run_time};
    $bbatch_info  =  $results->{batch_info};
    $brevise_date  =  $results->{revise_date};
    $bstart_wgt  =  $results->{start_wgt};
    $bfrom_batch  =  $results->{from_batch};
    $bbatch_size  =  $results->{batch_size};

    $bload1 =  $results->{load1};
    $bload2 =  $results->{load2};
    $bload3 =  $results->{load3};
    $bload4 =  $results->{load4};
    $bload5 =  $results->{load5};
    $bload6 =  $results->{load6};
    $bload7 =  $results->{load7};
    $bload8 =  $results->{load8};
    $bload9 =  $results->{load9};
    $bload10 =  $results->{load10};

    $bactual1 =  $results->{actual1};
    $bactual2 =  $results->{actual2};
    $bactual3 =  $results->{actual3};
    $bactual4 =  $results->{actual4};
    $bactual5 =  $results->{actual5};
    $bactual6 =  $results->{actual6};
    $bactual7 =  $results->{actual7};
    $bactual8 =  $results->{actual8};
    $bactual9 =  $results->{actual9};
    $bactual10 =  $results->{actual10};

    $badd1 =  $results->{add1};
    $badd2 =  $results->{add2};
    $badd3 =  $results->{add3};
    $badd4 =  $results->{add4};
    $badd5 =  $results->{add5};
    $badd6 =  $results->{add6};
    $badd7 =  $results->{add7};
    $badd8 =  $results->{add8};
    $badd9 =  $results->{add9};
    $badd10 =  $results->{add10};
         
#### RECIPE ITEMS
 
    $rnumber  =  $results->{recipe_number};
    $rrecipe  =  $results->{recipe};
    $rdate    =  $results->{recipe_date};
    $rtime    =  $results->{recipe_time};
    $rtank_temp =  $results->{tank_temp};
    $rpressure1 =  $results->{pressure1};
    $routlet_temp =  $results->{outlet_temp};
    $rai1 =  $results->{ai1};
    $rai2 =  $results->{ai2};
    $rai3 =  $results->{ai3};
    $rai4 =  $results->{ai4};
    $rai5 =  $results->{ai5};
    $rai6 =  $results->{ai6};
    $rai7 =  $results->{ai7};
    $rai8 =  $results->{ai8};
    $rai9 =  $results->{ai9};
    $rai10 =  $results->{ai10};
    $rpercent1 =  $results->{percent1};
    $rpercent2 =  $results->{percent2};
    $rpercent3 =  $results->{percent3};
    $rpercent4 =  $results->{percent4};
    $rpercent5 =  $results->{percent5};
    $rpercent6 =  $results->{percent6};
    $rpercent7 =  $results->{percent7};
    $rpercent8 =  $results->{percent8};
    $rpercent9 =  $results->{percent9};
    $rpercent10 =  $results->{percent10};
    $rtime1 =  $results->{time1};
    $rtime2 =  $results->{time2};
    $rtime3 =  $results->{time3};
    $rtime4 =  $results->{time4};
    $rtime5 =  $results->{time5};
    $rtime6 =  $results->{time6};
    $rtime7 =  $results->{time7};
    $rtime8 =  $results->{time8};
    $rtime9 =  $results->{time9};
    $rtime10 =  $results->{time10};


     &calc_totals; 
       
       
if ($rows == 1){
    $mw->messageBox(-message => "Batch succssfully loaded.\n", -type => "ok");	
}

if ($rows == 0){
    $mw->messageBox(-message => "Batch load failed !!!\n", -type => "ok");
    &new_batch;
}

if ($rows == 'undef'){
    $mw->messageBox(-message => "Load Error !!.\n", -type => "ok");	
}



}


sub save_batch {
    
    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			   $user, $pass,
			   {'RaiseError' => 1});
    
#Check for duplicate batch
    my $check_duplicate = ("SELECT batch FROM batch WHERE batch = '" .  $bbatch . "'");
    my $check = $dbh->prepare($check_duplicate);
    $check->execute(); 
    
#if duplicate show message and die
    my $matches =$check->rows;
    if ($matches >= 1) {
	$mw->messageBox(-message => "Duplicate batch. Cannot save!", -type => "ok");
	die;
    };
    
    if ($bbatch eq ""){
	$mw->messageBox(-message => "Bad batch name. Cannot save!", -type => "ok");
	die;
    }


#create the insert statement
    my $statement =  "INSERT INTO batch \(recipe_number, recipe, recipe_date, recipe_time, tank_temp,pressure1, outlet_temp, ai1, ai2, ai3, ai4, ai5, ai6, ai7, ai8, ai9, ai10, percent1, percent2, percent3, percent4, percent5, percent6, percent7, percent8, percent9, percent10, time1, time2, time3, time4, time5, time6, time7, time8, time9, time10, operator, batch_date, batch_time,  batch, run_date, run_time, batch_info, revise_date, start_wgt,from_batch, batch_size, load1, load2, load3, load4, load5, load6, load7, load8, load9, load10, actual1, actual2, actual3, actual4, actual5, actual6, actual7, actual8, actual9, actual10, add1, add2, add3, add4, add5, add6, add7, add8, add9, add10  \) VALUES \(" .  $rnumber . ",'" .   $rrecipe . "','" . $rdate . "','"  . $rtime . "'," . $rtank_temp . "," . $rpressure1 . "," . $routlet_temp . ",'" .   $rai1  . "','" .   $rai2  . "','"
.  $rai3  . "','" .  $rai4  . "','" .  $rai5  . "','" .  $rai6  . "','" .  $rai7  . "','" .  $rai8  . "','" .  $rai9  . "','" .  $rai10 . "'," .  $rpercent1  . "," .  $rpercent2  . "," .  $rpercent3  . "," .  $rpercent4  . "," .  $rpercent5  . "," .  $rpercent6  . "," .  $rpercent7 . "," .  $rpercent8  . "," .  $rpercent9  . "," .  $rpercent10   . ","  .  $rtime1  . "," .  $rtime2  . "," .  $rtime3  . "," .  $rtime4  . "," .  $rtime5  . "," .  $rtime6  . "," .  $rtime7  . "," .  $rtime8  . "," .  $rtime9  . "," .  $rtime10 . ",'" .   $boperator . "','" .   $bbatch_date  . "','" .   $bbatch_time . "','" .   $bbatch . "','" .   $brun_date. "','" .   $brun_time . "','" .   $bbatch_info  . "','" .   $brevise_date  . "'," .   $bstart_wgt  . ",'" .   $bfrom_batch  . "'," .   $bbatch_size    . "," .  $bload1  . "," .  $bload2  . "," .  $bload3  . "," .  $bload4  . "," .  $bload5  . "," .  $bload6  . "," .  $bload7  . "," .  $bload8  . "," .  $bload9  .  "," .  $bload10  .  "," .  $bactual1  .  "," .  $bactual2  .  "," .  $bactual3  .  "," .  $bactual4  .  "," .  $bactual5  .  "," .  $bactual6  .  "," .  $bactual7  .  "," .  $bactual8  .  "," .  $bactual9  .  "," .  $bactual10  .  "," .  $badd1  .  "," .  $badd2  .  "," .  $badd3  .  "," .  $badd4  .  "," .  $badd5  .  "," .  $badd6  .  "," .  $badd7  .  "," .  $badd8  .  "," .  $badd9  .  "," .  $badd10  .   "\)" ;
    
#print $statement . "\n";
    
#prepare and execute the statement
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute(); 
    
    
    if ($rows == 1){
	$mw->messageBox(-message => "Batch succssfully saved.\n", -type => "ok");	
    }
    
    if ($rows == 0){
	$mw->messageBox(-message => "Batch save failed !!!\n", -type => "ok");
    }
    
    if ($rows == 'undef'){
	$mw->messageBox(-message => "Save Error !!.\n", -type => "ok");	
    }
    
    
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



sub select_batch {
    
    $batch = "";
        
    if(! Exists($subwin2)){
	
	$subwin2 = $mw->Toplevel;
	$subwin2->geometry("300x150+100+100");
	$subwin2->title("Batch Select");
	my $subwin_button = $subwin2->Button(-text => "Load Batch",
					     -command => \&load_batch)->pack();
	
	my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			       $user, $pass,
			       {'RaiseError' => 1});
	
	my $statement =  "SELECT batch  FROM  batch";
	my $sth = $dbh->prepare($statement);
	$sth->execute(); 
	
	my $index=0;
	my @array;
	while ($results = $sth->fetchrow()) {
	    $array[$index] = $results;
	    $index++;
	    
    }
	my $lst = $subwin2->Scrolled('Listbox',-scrollbars => 'osow',-selectmode => 'single')->pack;
	$lst -> insert('end', @array);
	
	
	
### This run when item is list is selected and get the value.
	$lst->bind('<<ListboxSelect>>',
		   sub {
		       my @sel = $lst->curselection();
		       $batch =  $array[$sel[0]] . "\n";
		   } );
	
    }	
    
    else {
	$subwin2->deiconify();
	$subwin2->raise();
	
    }
}


sub calc_totals {
    
    $rpercent_total = $rpercent1 + $rpercent2 + $rpercent3 + $rpercent4 + $rpercent5 + $rpercent6 + $rpercent7 + $rpercent8 + $rpercent9 + $rpercent10; 
    $rtime_total = $rtime1 + $rtime2 + $rtime3 + $rtime4 + $rtime5 + $rtime6 + $rtime7 + $rtime8 + $rtime9 + $rtime10; 
    $bload_total = $bload1 + $bload2 + $bload3 + $bload4 + $bload5 + $bload6 + $bload7 + $bload8 + $bload9 + $bload10;
    $bactual_total = $bactual1 + $bactual2 + $bactual3 + $bactual4 + $bactual5 + $bactual6 + $bactual7 + $bactual8 + $bactual9 + $bactual10; 
    $badd_total = $badd1 + $badd2 + $badd3 + $badd4 + $badd5 + $badd6 + $badd7 + $badd8 + $badd9 + $badd10; 
	
}

sub calc_loads {
    
 $bload1 = ($rpercent1 / 100) * $bbatch_size;
 $bload2 = ($rpercent2 / 100) * $bbatch_size;
 $bload3 = ($rpercent3 / 100) * $bbatch_size;
 $bload4 = ($rpercent4 / 100) * $bbatch_size;
 $bload5 = ($rpercent5 / 100) * $bbatch_size;
 $bload6 = ($rpercent6 / 100) * $bbatch_size;
 $bload7 = ($rpercent7 / 100) * $bbatch_size;
 $bload8 = ($rpercent7/ 100) * $bbatch_size;
 $bload9 = ($rpercent8 / 100) * $bbatch_size;
 $bload10 = ($rpercent10 / 100) * $bbatch_size;

}


sub update_batch {


  my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			   $user, $pass,
			   {'RaiseError' => 1}); 
    
    my $statement =  "UPDATE batch SET " . 
	
	
	"recipe_number =" . "'" .$rnumber . "'," . 
	"recipe =" . "'"  .      $rrecipe . "'," . 
	"recipe_date =" . "'" .  $rdate . "'," . 
  	"recipe_time =" . "'" .  $rtime . "'," . 
  	"tank_temp =" .          $rtank_temp . "," . 
  	"pressure1 =" .          $rpressure1 . "," . 
  	"outlet_temp =" .        $routlet_temp . "," . 
  	"ai1 =" . "'" .          $rai1 . "', " .
	"ai2 =" . "'" .          $rai2 . "', " .
	"ai3 =" . "'" .          $rai3 . "', " .
	"ai4 =" . "'" .          $rai4 . "', " .
	"ai5=" . "'" .           $rai5 . "', " .
	"ai6 =" . "'" .          $rai6 . "', " .	 
	"ai7 =" . "'" .          $rai7 . "', " . 
	"ai8 = " . "'" .         $rai8 . "', " . 
	"ai9 =" . "'" .          $rai9 . "', " .	
	"ai10 =" . "'" .         $rai10 . "', " .
	"percent1 =" .           $rpercent1 . ", " . 
	"percent2 =" .           $rpercent2 . ", " . 
	"percent3 =" .           $rpercent3 . ", " .
	"percent4 =" .           $rpercent4 . ", " . 
	"percent5 =" .           $rpercent5 . ", " . 
	"percent6 =" .           $rpercent6 . ", " . 
	"percent7 =" .           $rpercent7 . ", " . 
	"percent8 =" .           $rpercent8 . ", " . 
	"percent9 =" .           $rpercent9 . ", " . 
	"percent10 =" .          $rpercent10 . ", " . 
	"time1 = " .             $rtime1 . ", " . 
	"time2 = " .             $rtime2 . ", " . 
	"time3 = " .             $rtime3 . ", " . 
	"time4 = " .             $rtime4 . ", " . 
	"time5 = " .             $rtime5 . ", " . 
	"time6 = " .             $rtime6 . ", " . 
	"time7 = " .             $rtime7 . ", " . 
	"time8 = " .             $rtime8 . ", " . 
	"time9 = " .             $rtime9 . ", " . 
	"time10 = " .            $rtime10 . ", " . 
	"operator = " . "'" .    $boperator . "', " .
	"batch_date =" . "'" .   $bbatch_date . "', " .
	"batch_time =" . "'" .   $bbatch_time . "', " .
	"batch =" . "'" .        $bbatch . "', " .
	"run_date =" . "'" .     $brun_date . "', " .
	"run_time =" . "'" .     $brun_time . "', " .
	"batch_info =" . "'" .   $bbatch_info . "', " .
	"revise_date =" . "'" .  $brevise_date . "', " .	 
	"start_wgt =" .          $bstart_wgt . ", " . 
	"from_batch = " . "'" .  $bfrom_batch . "', " . 
	"batch_size =" .         $bbatch_size . ", " .	
	"load1 =" .              $bload1 . ", " . 
	"load2 =" .              $bload2 . ", " . 
	"load3 =" .              $bload3 . ", " .
	"load4 =" .              $bload4 . ", " . 
	"load5 =" .              $bload5 . ", " . 
	"load6 =" .              $bload6 . ", " . 
	"load7 =" .              $bload7 . ", " . 
	"load8 =" .              $bload8 . ", " . 
	"load9 =" .              $bload9 . ", " . 
	"load10 =" .             $bload10 . ", " . 
	"actual1 =" .            $bactual1 . ", " .
	"actual2 =" .            $bactual2 . ", " .
	"actual3 =" .            $bactual3 . ", " .
	"actual4 =" .            $bactual4 . ", " .
	"actual5 =" .            $bactual5 . ", " .
	"actual6 =" .            $bactual6 . ", " .
	"actual7 =" .            $bactual7 . ", " .
	"actual8 =" .            $bactual8 . ", " .
	"actual9 =" .            $bactual9 . ", " .
	"actual10 =" .           $bactual10 . ", " .
	"add1 =" .               $badd1 . ", " .
	"add2 =" .               $badd2 . ", " .
	"add3 =" .               $badd3 . ", " .
	"add4 =" .               $badd4 . ", " .
	"add5 =" .               $badd5 . ", " .
	"add6 =" .               $badd6 . ", " .
	"add7 =" .               $badd7 . ", " .
	"add8 =" .               $badd8 . ", " .
	"add9 =" .               $badd9 . ", " .
	"add10 =" .              $badd10 . "  " .

	
	"WHERE batch =" . "'" .  $bbatch . "'" ;
 
  #print $statement;

    #prepare and execute the statement
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute(); 
    
    if ($rows == 1){
	$mw->messageBox(-message => "Batch succssfully updated.\n", -type => "ok");	
    }

    if ($rows == 0){
	$mw->messageBox(-message => "Batch update failed !!!\n", -type => "ok");	
    }

     if ($rows == 'undef'){
	$mw->messageBox(-message => "Update Error !!.\n", -type => "ok");	
    }

}


sub new_batch {

    $boperator  =  'XXX';
    $bbatch_date  = &UnixDate("today","%Y-%m-%d"); 
    $bbatch_time  =   &UnixDate("now","%H:%M");
    $bbatch  =  '';
    $brun_date  =  &UnixDate("today","%Y-00-00");;
    $brun_time  =    '00:00';
    $bbatch_info  =  '';
    $brevise_date  =  '';
    $bstart_wgt  =  '0';
    $bfrom_batch  =  '';
    $bbatch_size  =  '0';

    $bactual1 =   '0';
    $bactual2 =   '0';
    $bactual3 =   '0';
    $bactual4 =   '0';
    $bactual5 =   '0';
    $bactual6 =   '0';
    $bactual7 =   '0';
    $bactual8 =   '0';
    $bactual9 =   '0';
    $bactual10 =  '0';

    $badd1 =   '0';
    $badd2 =   '0';
    $badd3 =   '0';
    $badd4 =   '0';
    $badd5 =   '0';
    $badd6 =   '0';
    $badd7 =   '0';
    $badd8 =   '0';
    $badd9 =   '0';
    $badd10 =  '0';

    &calc_totals;
    &calc_loads;
}
