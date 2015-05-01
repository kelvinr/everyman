var startDate = document.getElementById('schedule_start_date');
var endDate = document.getElementById('schedule_end_date');
var dailySleepGoal = document.getElementById('schedule_daily_sleep_goal');
var coreSleep = document.getElementById('schedule_core_sleep');
var napDuration = document.getElementById('schedule_nap_duration');

$(startDate).datetimepicker({
  timepicker: false,
  format: 'Y-m-d',
  minDate: '-1970/01/01',
  closeOnDateSelect: true
});

$(endDate).datetimepicker({
  timepicker: false,
  format: 'Y-m-d',
  closeOnDateSelect: true
});

$(dailySleepGoal).datetimepicker({
  datepicker: false,
  format: 'H:i',
  allowTimes: ['2:00','2:15','2:30','2:45','3:00','3:15',
  '3:30','3:45','4:00','4:15','4:30','4:45','5:00','5:15',
  '5:30','5:45','6:00','6:15','6:30','6:45','7:00',
  '7:15','7:30','7:45','8:00']
});

$(coreSleep).datetimepicker({
  datepicker: false,
  format: 'H:i',
  allowTimes: ['2:00','2:15','2:30','2:45','3:00','3:15',
  '3:30','3:45','4:00','4:15','4:30','4:45','5:00','5:15',
  '5:30','5:45','6:00','6:15','6:30','6:45','7:00',
  '7:15','7:30','7:45','8:00']
});

$(napDuration).datetimepicker({
  datepicker: false,
  format: 'H:i',
  allowTimes: ['0:05','0:10','0:15','0:20','0:25','0:30',
  '0:35','0:40','0:45','0:50','0:55','1:00','1:05','1:10',
  '1:15','1:20','1:25','1:30','1:35','1:40','1:45','1:50',
  '1:55','2:00','2:05','2:10','2:15','2:20','2:25','2:30',
  '2:35','2:40','2:45','2:50','2:55','3:00','3:00','3:05',
  '3:10','3:15','3:20','3:25','3:30','3:35','3:40','3:45',
  '3:50','3:55','4:00']
});
