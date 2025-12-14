//---------------------------- Axis Control ---------------------------------

#define	  SET_1 		0x01	// Set current axis # to 1
#define	  SET_2 		0x02    // Set current axis # to 2
#define	  SET_3 		0x03    // Set current axis # to 3
#define	  SET_4 		0x04    // Set current axis # to 4
#define	  INTERRUPT		0x08    // Set current axis # to the interrupting axis

//------------------------- Profile Generation -----------------------------

#define	  SET_PRFL_S_CRV	0x0b    // Set profile mode to S-curve
#define	  SET_PRFL_TRAP		0x09    // Set profile mode to trapezoidal point to point
#define	  SET_PRFL_VEL		0x0a    // Set profile mode to velocity-contouring
#define	  SET_PRFL_GEAR		0x0c    // Set profile mode to electronic gear
#define   SET_POS               0x10    // Set command position
#define   SET_VEL               0x11    // Set command velocity
#define   SET_ACC               0x12    // Set command acceleration
#define   SET_MAX_ACC           0x15    // Set max acceleration (S-curve profile only)
#define   SET_JERK              0x13    // Set command jerk
#define   SET_RATIO             0x14    // Set command electronic gear ratio
#define   CLR_PRFL              0x46    // Zero target velocity,target acceleration and fractional target position
#define   SYNCH_PRFL            0x47	// Set target position equal to the actual position
#define   ZERO_POS              0x3f	// Zero actual position and target position
#define	  GET_POS		0x4a	// Get command position
#define	  GET_VEL		0x4b	// Get command velocity
#define	  GET_ACC		0x4c	// Get command acceleration
#define	  GET_MAX_ACC		0x4f	// Get max acceleration (S-curve only)
#define	  GET_JERK		0x58	// Get command jerk
#define	  GET_RATIO		0x59	// Get command electronic gear ratio
#define	  GET_TRGT_POS		0x1d	// Get command target position
#define	  GET_TRGT_VEL		0x1e	// Get command target velocity

//---------------------------- Digtal Filter --------------------------------

#define   SET_FLTR_PID		0x21    // Set digital filter mode to PID
#define   SET_FLTR_PIVFF	0x22    // Set digital filter made to PIVff
#define   SET_KP		0x25    // Set propotion gain
#define   SET_KD		0x27    // Set derivative gain
#define   SET_KI		0x26    // Set integral gain
#define   SET_KV		0x2a    // Set velocity gain
#define   SET_KVFF		0x2b    // Set feedforward gain
#define   SET_I_LIM 		0x28    // Set integration limit
#define   SET_POS_ERR 		0x29    // Set maximum position error limit
#define   GET_KP		0x50    // Get propotion gain
#define   GET_KD		0x52    // Get derivative gain
#define   GET_KI		0x51    // Get integral gain
#define   GET_KV		0x5A    // Get velocity gain
#define   GET_KVFF		0x54    // Get velocity feedforward gain
#define   GET_I_LIM 		0x53    // Get integration limit
#define   GET_POS_ERR 		0x55    // Get position error
#define   GET_INTGR		0x2e    // Get integrated position error value
#define   GET_ACTL_POS_ERR	0x60    // Get actual position error
#define   SET_AUTO_STOP_ON	0x45	// Set auto stop on motion error mode on
#define   SET_AUTO_STOP_OFF	0x44	// Set auto stop on motion error mode off

//---------------------------- Parameter update -----------------------------

#define   SET_TIME_BRK          0x17    // Set breakpoint mode to time
#define	  SET_POS_BRK           0x18    // Set breakpoint mode to pos. target position
#define   SET_NEG_BRK           0x19    // Set breakpoint mode to neg. target position
#define   SET_POS_ACTL_BRK      0x1b    // Set breakpoint mode to pos. actual position
#define   SET_NEG_ACTL_BRK      0x1c    // Set breakpoint mode to neg. actual position
#define   SET_BRK_OFF           0x6d    // Set breakpoint mode off
#define   SET_BRK_PNT           0x16    // Set breakpoint comparison value
#define   UPDATE                0x1a	// Immediate parameter update
#define   MULTI_UPDATE          0x5b	// Multiple axis immediate parameter update
#define   SET_AUTO_UPDATE_ON    0x5c	// Set automatic profile update on
#define   SET_AUTO_UPDATE_OFF   0x5d	// Set automatic profile update off
#define   GET_BRK_PNT           0x57	// Get breakpoint comparison value

//---------------------------- Interrupt Processing ------------------------

#define   SET_INTRPT_MASK	0x2f	// Set interrupt mask
#define   GET_INTRPT		0x30	// Get status of interrupting axis
#define   RST_INTRPT		0x32	// Reset interrupting events
#define   GET_INTRPT_MASK	0x56	// Get interrupt mask

//---------------------------- Status/Mode ---------------------------------

#define   CLR_STATUS		0x33	// Reset status of current axis
#define   RST_STATUS		0x34	// Reset events for current axis
#define   GET_STATUS		0x31	// Get axis status word
#define   GET_MODE		0x48	// Get axis mode word

//---------------------------- Encoder -------------------------------------

#define   SET_CNTS		0x68	// Set # of counts per motor rotation (-P vrsn only)
#define   SET_CAPT_INDEX	0x64	// Set index signal as position trigger
#define   SET_CAPT_HOME		0x65	// Set home signal as position trigger
#define	  GET_CAPT              0x36	// Get current axis position capture location
#define   GET_CNTS		0x6f	// Get # of counts per motor rotation (-P vrsn only)

//---------------------------- Motor ---------------------------------------

#define   SET_OUTPUT_PWM	0x3c	// Set motor output mode to PWM
#define   SET_OUTPUT_DAC12	0x3d	// Set motor output mode to 12-bit DAC
#define   SET_OUTPUT_DAC16	0x3b	// Set motor output mode to 16-bit DAC
#define   MTR_ON		0x43	// Enable motor output
#define   MTR_OFF		0x42	// Disable motor output
#define   SET_MTR_CMD           0x62    // Write direct value to motor output
#define   SET_BUF_MTR_CMD       0x77    // Write double buffered to motor command output
#define   GET_OUTPUT_MODE       0x6e    // Get current output mode
#define   GET_BUF_MTR_CMD       0x69    // Get double buffered motor command value

//---------------------------- Miscellaneous -------------------------------

#define   AXIS_ON               0x41    // Enable axis
#define   AXIS_OFF              0x40    // Disable axis
#define   GET_ACTL_POS          0x37    // Get current actual axis location
#define   SET_LMT_SENSE         0x66    // Set limit switch bit sense
#define   GET_LMT_SENSE         0x67    // Get state of limit switches
#define   LMTS_ON               0x70    // Set limit sensing on
#define   LMTS_OFF              0x71    // Set limit sensing off
#define   SET_SMPL_TIME         0x38    // Set servo loop sample time
#define   GET_SMPL_TIME         0x61    // Get servo loop sample time
#define   RESET                 0x39    // Reset chipset
#define   GET_VRSN              0x6c    // Get chipset software version information
#define   GET_TIME              0x3e    // Get current chipset time (# servo loop)

//---------------------------- Communication (-B Parts Only) ---------------

#define   SET_PHASE_BRUSH       0x73    // Set waveform to brushless (3-phase)
#define   SET_PHASE_STEPPER     0x74    // Set waveform to stepper (2-phase)
#define   SET_PHASE_MICRO       0x63    // Set commutation mode to microstepping
#define   SET_PHASE_ENC         0x5f    // Set commutation mode to encoder-based
#define   SET_PHASE_HALL        0x78    // Set phase initialization to Hall-based
#define   SET_PHASE_ALGOR       0x79    // Set phase initialization to Algorithmic
#define   PRESCALE_ON           0x0d    // Set encoder prescale on
#define   PRESCALE_OFF          0x0e    // Set encoder prescale off
#define   SET_PHASE_CNTS        0x75    // Set number of encoder counts per commutation cycle
#define   SET_PHASE_TIME        0x72    // Set amount of time to wait after phase init.
#define   SET_PHASE_CMD         0x77    // Set motor output level
#define   SET_PHASE_OFFSET      0x76    // Set phase offset value
#define   SET_KPHASE            0x1f    // Set velocity phase advance gain
#define   SET_HALL_SENSE        0x23    // Set Hall-sensor logic level interpretation
#define   INIT_PHASE            0x7a    // Perform phase initialization procedure
#define   GET_PHASE_INFO        0x7f    // Get commutation flags set by host
#define   GET_PHASE_CNTS        0x7d    // Get number of encoder counts per commutation cycle
#define   GET_PHASE_TIME        0x7c    // Get amount of time to wait after phase init
#define   GET_PHASE_OFFSET      0x7b    // Get phase offset value
#define   GET_KPHASE            0x20    // Get velocity phase advance gain
#define   GET_HALL_SENSE        0x24    // Get Hall-sensor logic level interpretation
#define   GET_HALLS             0x7e    // Get state of Hall sensor
#define   GET_PHASE             0x2c    // Get current commutation phase angle

//----------------------------- end init command ----------------------------
