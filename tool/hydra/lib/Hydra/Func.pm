#------------------------------------------------------
# Module Name: Func
# Date:        Fri Mar 22 15:53:43 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func;

use Hydra::Func::ConnectInterface;
use Hydra::Func::RtlCopy;
use Hydra::Func::SdcCopy;
use Hydra::Func::ReportGitInfo;
use Hydra::Func::PromoteSdc;
use Hydra::Func::Incoming;
use Hydra::Func::BumpMap;
use Hydra::Func::WorstGlobalTiming;
use Hydra::Func::ReportInterfaceTimingMargin;
use Hydra::Func::License;
use Hydra::Func::TraceClock;
use Hydra::Func::TraceHierarchy;
use Hydra::Func::ConvertLib;
use Hydra::Func::TracePower;
use Hydra::Func::EditScanPattern;
use Hydra::Func::Padframe;
use Hydra::Func::Dashboard;
use Hydra::Func::VTSwap;
use Hydra::Func::ManError;
use Hydra::Func::NetlistNavi;
use Hydra::Func::WriteSTAKickoff;
use Hydra::Func::SplitECO;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------

1;
