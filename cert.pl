#!/usr/bin/perl


#Tim Gray - Wed Apr 21, 2010 11:12

use Tk;
use DBI;
use Date::Manip;
use Tk::ErrorDialog;
use  Tk::HList;
use  Tk::BrowseEntry;
use Tk::LabFrame;
use Tk::DateEntry;
use Date::Format;


$database =  "????";
$user = "????";
$pass = "????";
$host = "localhost";
$message = "Quality Control Certification";
$ycorr = 100;
$xcorr = 40;


# Main Window
my $mw = new MainWindow;
$mw->geometry("450x680");
$mw->title("Quality Control Certification");


my $cframe = $mw->LabFrame(
    -label => "Certification",
    -labelside => 'acrosstop',
    -width => 100,
    -height => 100,
    )->place(-x=>10,-y=>40);


$lcblank1 = $cframe -> Label(-text => ""); 
$lcblank2 = $cframe -> Label(-text => ""); 
$lcblank3 = $cframe -> Label(-text => ""); 
$lcblank4 = $cframe -> Label(-text => ""); 
$lcblank5 = $cframe -> Label(-text => ""); 
$lcblank6 = $cframe -> Label(-text => ""); 

my $ltest = $cframe -> Label(-text => "Test Number:");
my $ldate = $cframe -> Label(-text => "Date:"); 
my $ltime = $cframe -> Label(-text => "Time:");
my $lrtank = $cframe -> Label(-text => "Tank"); 
my $lrtruck = $cframe -> Label(-text => "Truck"); 
my $lrbatch = $cframe -> Label(-text => "Batch"); 

my $lproduct = $cframe -> Label(-text => "Product Ident:"); 
my $ltank = $cframe -> Label(-text => "Tank Number:"); 
my $lshipper = $cframe -> Label(-text => "Shipper Number:"); 
my $lbatch = $cframe -> Label(-text => "Batch Number:"); 

my $lanalysis = $cframe -> Label(-text => "ANALYSIS" , -bg => 'green');
my $ltemp = $cframe -> Label(-text => "Temp:"); 
my $lph = $cframe -> Label(-text => "pH:"); 
my $lshear = $cframe -> Label(-text => "Shear Value::"); 
my $lsolids = $cframe -> Label(-text => "Solids:"); 
my $lviscosity = $cframe -> Label(-text => "Viscosity:"); 
my $lsg = $cframe -> Label(-text => "Specific Gravity:"); 
my $lseperation = $cframe -> Label(-text => "Seperation:"); 
my $lcertified = $cframe -> Label(-text => "Certified By:"); 
my $lnotes = $cframe -> Label(-text => "Notes:"); 


my $llanalysis = $cframe -> Label(-text => "RANGE", -bg => 'green');
my $lltemp = $cframe -> Label(-text => "75-80 degF"); 
my $llph = $cframe -> Label(-text => "8.5-9.5"); 
my $llshear = $cframe -> Label(-text => "Pass > 3 min"); 
my $llsolids = $cframe -> Label(-text => "50-59%"); 
my $llviscosity = $cframe -> Label(-text => "180-250 cp"); 
my $llsg = $cframe -> Label(-text => "9-10"); 
my $llseperation = $cframe -> Label(-text => "????"); 


my $lllanalysis = $cframe -> Label(-text => "RESULTS", -bg => 'green');

my $csample = 'Truck';
my $ltakenfrom = $cframe -> Label(-text => "Sample:");
my $rtank = $cframe->Radiobutton(-text => "", -value => "Tank", -variable=> \$csample);
my $rtruck = $cframe->Radiobutton(-text => "", -value => "Truck", -variable=> \$csample);
my $rbatch = $cframe->Radiobutton(-text => "", -value => "Batch", -variable=> \$csample,);
my $etest = $cframe -> Entry(-background => 'yellow', -width => '10', -foreground => 'black',-textvariable => \$ctest, -state=> 'disabled',-disabledforeground => 'black',);
my $edate=$cframe->DateEntry(-weekstart=>1,-daynames=>[qw/Sun Mon Tue Wed Thu Fri Sat/],-dateformat => 4,-textvariable => \$cdate,);
my $etime = $cframe -> Entry(-background => 'yellow', -width => '10', -foreground => 'black', -textvariable => \$ctime,);

my $eproduct = $cframe -> Entry(-background => 'white', -width => '10', -foreground => 'black',-textvariable => \$cproduct);
my $etank = $cframe -> Entry(-background => 'white', -width => '10', -foreground => 'black', -textvariable => \$ctank);
my $eshipper = $cframe -> Entry(-background => 'white', -width => '10', -foreground => 'black',-textvariable => \$cshipper);
my $ebatch = $cframe -> Entry(-background => 'white', -width => '10', -foreground => 'black',-textvariable => \$cbatch);
my $etemp = $cframe -> Entry(-background => 'white', -width => '10',-foreground => 'black', -textvariable => \$ctemp);

my $eph = $cframe -> Entry(-background => 'white', -width => '10', -foreground => 'black',-textvariable => \$cph);
my $eshear = $cframe -> Entry(-background => 'white', -width => '10', -foreground => 'black',-textvariable => \$cshear);
my $esolids = $cframe -> Entry(-background => 'white', -width => '10', -foreground => 'black',-textvariable => \$csolids);
my $eviscosity = $cframe -> Entry(-background => 'white', -width => '10', -foreground => 'black',-textvariable => \$cviscosity);
my $esg = $cframe -> Entry(-background => 'white', -width => '10', -foreground => 'black',-textvariable => \$csg);
my $eseperation = $cframe -> Entry(-background => 'white', -width => '10', -foreground => 'black',-textvariable => \$cseperation);
my $ecertified = $cframe -> Entry(-background => 'white', -width => '10', -foreground => 'black',-textvariable => \$ccertified);
my $enotes = $cframe->Text(qw/-width 59 -height 4/ ,  -background => 'white', -foreground => 'black',-font => 'Arial 10');
$enotes->insert('end', '');

my $load_cert = $mw -> Button(-text => "Select", -command =>\&select_cert)->pack(-side=>'left',-anchor => 'n');
my $save_cert = $mw -> Button(-text => "Save",  -command =>\&save_cert)->pack(-side=>'left',-anchor => 'n');
my $new_cert = $mw -> Button(-text => "New",  -command =>\&new_cert)->pack(-side=> 'left', -anchor => 'n');
my $update_cert = $mw -> Button(-text => "Update",  -command =>\&update_cert)->pack(-side=>'left',-anchor => 'n');
my $delete_ask = $mw -> Button(-text => "Delete",  -command =>\&delete_ask)->pack(-side=> 'left', -anchor => 'n');
my $cert_print = $mw -> Button(-text => "Print",  -command =>\&cert_print)->pack(-side=> 'left', -anchor => 'n');

$lcblank1->grid();
$ltest-> grid($etest);
$ldate->grid($edate);
$edate->place(-x => 184, -y => 45);

$ltime->grid($etime);
$lrtank->grid($lrtruck,$lrbatch);
$rtank-> grid($rtruck,$rbatch);
$lproduct->grid($eproduct);
$ltank->grid($etank);
$lshipper->grid($eshipper);
$lbatch->grid($ebatch);

$lcblank3->grid();
$lanalysis->grid($llanalysis,$lllanalysis);
$ltemp->grid($lltemp,$etemp);
$lph->grid($llph,$eph);
$lshear->grid($llshear,$eshear);
$lsolids->grid($llsolids,$esolids);
$lviscosity->grid($llviscosity,$eviscosity);
$lsg->grid($llsg,$esg);
$lseperation->grid($llseperation,$eseperation);
$lcertified->grid('x',$ecertified);
$lcblank4->grid();
$lnotes->grid();
$enotes->grid(-column=>0,-columnspan=>3);

MainLoop;


sub new_cert {


    $enotes->delete('1.0',  end);
    
    $ctest  =  "AUTO NO.";
    $cdate =  &UnixDate("today","%Y-%m-%d");
    $ctime = &UnixDate("now","%H:%M");  
    $cproduct = ""; 
    $ctank =  "";
    $cshipper =  "";
    $cbatch =  "";
    $ctemp =  "0";
    $cph =  "0";
    $cshear =  "0";
    $csolids = "0"; 
    $cviscosity = "0"; 
    $csg =  "0";
    $cnotes =  "";
    $ccertified = "XXX"; 
    $cseperation =  "0";
    
    $enotes->insert(end, $cnotes);
}

sub load_cert {
    
    $subwin1->destroy;
    $enotes->delete('1.0',  end);
     
    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
  		   $user, $pass,
			   {'RaiseError' => 1});
    
    
    my $statement =  "SELECT test, sample, date, time, product,  tank,  shipper, batch, temp, ph, shear, solids, viscosity, sg, notes, certified, seperation, notes FROM cert WHERE test   = '"  .  $cert . "'";
    
    
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute();
    my $results = $sth->fetchrow_hashref;
    
    $ctest  =  $results->{test};
    $csample =  $results->{sample};
    $cdate =  $results->{date};
    $ctime =  $results->{time};
    $cproduct =  $results->{product};
    $ctank =  $results->{tank};
    $cshipper =  $results->{shipper};
    $cbatch =  $results->{batch};
    $ctemp =  $results->{temp};
    $cph =  $results->{ph};
    $cshear =  $results->{shear};
    $csolids =  $results->{solids};
    $cviscosity =  $results->{viscosity};
    $csg =  $results->{sg};
    $cnotes =  $results->{note};
    $ccertified =  $results->{certified};
    $cseperation =  $results->{seperation};
    
    $cnotes =  $results->{notes};
    $enotes->insert(end, $cnotes);
    
    if ($rows ==  1) {
	$mw->messageBox(-message => "Test loaded sucessfully.\n", -type => "ok");
    };
    if ($rows ==  0) {
	$mw->messageBox(-message => "Test did not load !!\n", -type => "ok");
    };
    if ($rows ==  'undef') {
	$mw->messageBox(-message => "Test load error !!\n", -type => "ok");
	
    };
    
    
    
}




sub update_cert {
    
    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			   $user, $pass,
			   {'RaiseError' => 1});
       
    my  $notes = $enotes -> get('0.1','end');
    chomp($notes);
    
    #create the update statement
    my $statement =  "UPDATE cert SET " . 
	
	"sample = " .  "'" .  $csample . "', " .
	"date = " .  "'" .  $cdate . "', " .
	"time =" . "'" . $ctime . "', " .
	"product =" . "'" .  $cproduct . "', " .
	"tank =" . "'" .  $ctank . "', " .
	"shipper =" . "'" . $cshipper . "', " .
	"batch =" . "'" .  $cbatch . "', " .
	"temp =" .  $ctemp . ", " .	 
	"ph =" .   $cph . ", " . 
	"shear = " . "'" . $cshear . "', " . 
	"solids =" .   $csolids . ", " .	
	"viscosity =" .   $cviscosity . ", " .
	"sg =" . $csg . ", " . 
	"notes = " . "'" . $notes . "', " . 
	"certified =" . "'" . $ccertified . "', " .
	"seperation =" . $cseperation . " " . 

	"WHERE test =" .  $ctest  ;
    
    #prepare and execute the statement
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute(); 
  
    if ($rows == 1){
      $mw->messageBox(-message => "Test succssfully updated.\n", -type => "ok");	
    }
    
    if ($rows == 0){
	$mw->messageBox(-message => "Test update failed !!!\n", -type => "ok");	
    }
    
    if ($rows == 'undef'){
	$mw->messageBox(-message => "Update Error !!.\n", -type => "ok");	
    }
    
}


sub save_cert {
    
    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			   $user, $pass,
			   {'RaiseError' => 1});
    
    # get the last test number add a 1 -- this is the primary key
    my $statement =  "SELECT max(test) FROM cert";
    my $sth = $dbh->prepare($statement);
    $sth->execute(); 
    $vtest  = $sth->fetchrow_array;
    $vtest++;
    #$vtest = 1;
    
    my $notes = $enotes -> get('0.1','end');
    chomp($notes);

    my $statement =   "INSERT INTO cert (test,sample,date,time,product,tank,shipper,batch,temp,ph,shear,solids,viscosity,sg,certified,notes) VALUES \(" . $vtest . ",'" . $csample . "','" . $cdate  . "','" . $ctime  . "','" . $cproduct  . "','" . $ctank  . "','" . $cshipper  . "','" . $cbatch  . "'," . $ctemp  . "," . $cph  . ",'" . $cshear  . "'," .  $csolids  . "," . $cviscosity  . "," . $csg . ",'" . $ccertified . "','" . $notes .  "'\)" ;
    
    
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute();
        

if ($rows ==  1) {
    $mw->messageBox(-message => "Test saved sucessfully.\n", -type => "Close");
    exit;
};
if ($rows ==  0) {
    $mw->messageBox(-message => "Test did not save !!\n", -type => "ok");
    
};
if ($rows ==  'undef') {
    $mw->messageBox(-message => "Test save error !!\n", -type => "ok");
};
    
    
 
}



sub select_cert {
    
    $cert = "";
        
    if(! Exists($subwin1)){
	
	$subwin1 = $mw->Toplevel;
	$subwin1->geometry("300x150+100+100");
	$subwin1->title("Certification Select");
	my $subwin_button = $subwin1->Button(-text => "Load Cert",
					     -command => \&load_cert)->pack();
	
	my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			       $user, $pass,
			       {'RaiseError' => 1});
	
	my $statement =  "SELECT test,date,time FROM  cert";
	my $sth = $dbh->prepare($statement);
	$sth->execute(); 
	
	my $index=0;
       	my @array;
	while (@results = $sth->fetchrow()) {
	    $array[$index][0] = $results[0];
	    $array[$index][1] = "-";
	    $array[$index][2] = $results[1];
	    $array[$index][3] = "-";
	    $array[$index][4] = $results[2];
	    $index++;
	    
	    
    }
	


	my $lst = $subwin1->Scrolled('Listbox',-scrollbars => 'osow',-selectmode => 'single')->pack;
	$lst -> insert('end', @array);
	
	
	
### This run when item is list is selected and get the value.
	$lst->bind('<<ListboxSelect>>',
		   sub {
		       my @sel = $lst->curselection();
		       $cert =  $array[$sel[0]][0] . "\n";
		   } );
	
    }	
    
    else {
	$subwin1->deiconify();
	$subwin1->raise();
	
    }
}




sub delete_cert {
    
    $subwin3->destroy;
    
    my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host",
			   $user, $pass,
			   {'RaiseError' => 1});
    
    my $statement =  "DELETE FROM cert WHERE test = '" . $ctest . "'";


   #prepare and execute the statement
    my $sth = $dbh->prepare($statement);
    my $rows = $sth->execute(); 
    
    if ($rows == 1){
	$mw->messageBox(-message => "Test succssfully deleted.\n", -type => "ok");	
    }

    if ($rows == 0){
	$mw->messageBox(-message => "Test delete failed !!!\n", -type => "ok");	
    }

     if ($rows == 'undef'){
	$mw->messageBox(-message => "Delete Error !!.\n", -type => "ok");	
    }
    
} 


sub delete_ask {
        
    
    if(! Exists($subwin3)){
	
	$subwin3 = $mw->Toplevel;
	$subwin3->geometry("300x150+600+400");
	$subwin3->title("Delete Test");
	my $label  =  $subwin3 -> Label(-text => "Are you sure you want \n  to delete test \n " . $ctest . "", -font => "{Arial} 14" )->pack(); 
	my $subwin_button1 = $subwin3->Button(-text => "Yes", -font => "{Arial} 14", -command => \&delete_cert)->pack();
	my $subwin_button2 = $subwin3->Button(-text => "No", -font => "{Arial} 14", -command => [$subwin3 => 'destroy'])->pack();
	
    }
    
    else {
	$subwin3->deiconify();
	$subwin3->raise();
	
    }
    
}


sub cert_print {
    
    open FILE, ">/lab/cert_print.dat";
    
    $text = "TEST: $ctest \nDATE: $cdate \nTIME: $ctime \nPROD: $cproduct \nTANK: $ctank \nSHIPPER: $cshipper \nBATCH:\t $cbatch \nTEMP: $ctemp \nPH: $cph \nSHEAR: $cshear \nSOLIDS: $csolids \nVISCOSITY: $cviscosity \nSPECIFIC GRAVITY: $csg \nSEPERATION: $cseperation \nCERTIFIED BY: $ccertified \nNOTES: $cnotes \n"; 

    print FILE $text;
    close(FILE);

    
    system("enscript /lab/cert_print.dat -i 2 -f Times-Roman16");
    
    
}
