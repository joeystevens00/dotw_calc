use strict;
use warnings;
use feature 'say';

# is_leap_year()
#    The year can be evenly divided by 4;
#    If the year can be evenly divided by 100, it is NOT a leap year, unless;
#    The year is also evenly divisible by 400. Then it is a leap year.
sub is_leap_year {
    my $year = shift;
    $year % 4 == 0 && (($year % 100 == 0 && $year % 400 == 0) || $year % 100 != 0)
}

# dotw_calc($day, $month, $year)
# using the Key Value Method to determine the day of the week
sub dotw_calc {
  my ($day, $month, $year) = @_;
  my $months_codes = {
    "01" => 1,
    "02" => 4,
    "03" => 4,
    "04" => 0,
    "05" => 2,
    "06" => 5,
    "07" => 0,
    "08" => 3,
    "09" => 6,
    "10" => 1,
    "11" => 4,
    "12" => 6
  };
  my $century_codes = {
    "17" => 4,
    "18" => 2,
    "19" => 0,
    "20" => 6
  };
  my $dotw = {
    0 => "Saturday",
    1 => "Sunday",
    2 => "Monday",
    3 => "Tuesday",
    4 => "Wednesday",
    5 => "Thursday",
    6 => "Friday"
  };
  $month = length($month) eq 1 ? "0$month" : $month;
  my ($yearCentury, $yearTwoDigit) = (int(substr($year, 0, 2)), int(substr($year, 2, 4)));
  my $month_v = $months_codes->{$month};
  my $century_v = $century_codes->{$yearCentury};
  # Support Centuries <1700 or >2000
  until($century_v) {
    $yearCentury = $yearCentury < 17 ? $yearCentury+4 : $yearCentury-4;
    $century_v = $century_codes->{$yearCentury};
  }

  my $leap_year = is_leap_year($year) && ($month eq "01" || $month eq "02") ? 1 : 0;
  my $dotw_int = (int($yearTwoDigit /4)+$day+$month_v-$leap_year+$century_v+$yearTwoDigit) % 7;
  $dotw->{$dotw_int}
}

say dotw_calc(@ARGV)
