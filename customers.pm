################################################################
#
#	Name:		customers.pm
#	Desc:		RTIR Customers CF External Source
#	Created:	12/17/2013 - Francisco Losada
#
#	Howto:	1- Create the following directory: 
#		/usr/local/share/request-tracker4/lib/RT/CustomFieldValues
#
#		2- Put this file on the previously created directory
#
#		3- Create a 'my_customers.csv' file with one customer per line
#		and put this file on previously created directory
#
#		4- Edit /etc/request-tracker4/RT_SiteConfig.pm and add:
#
#		Set(@CustomFieldValuesSources, 
#			"RT::CustomFieldValues::Customers");
#
#		5- Update RT: Execute 'update-rt-siteconfig-4'
#
#		6- Restart Apache server
#
#
################################################################

package RT::CustomFieldValues::Customers;

use strict;
use warnings;

use base qw(RT::CustomFieldValues::External);

my @res;
# create your own csv file
my $csvPath = '/usr/local/share/request-tracker4/lib/RT/CustomFieldValues/my_customers.csv';

open( my $input_fh, "<", $csvPath ) or die $!;
my @lines = <$input_fh>;

# admin friendly description, the default valuse is the name of the class
sub SourceDescription {
	return 'Customers';
  }
  
# actual values provider method
sub ExternalValues {

	foreach (@lines) { push @res, { name => $_, };  }

	return \@res;
}

RT::Base->_ImportOverlays();

1;

