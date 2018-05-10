#encoding : utf-8

require 'rufus-scheduler'

# example

# scheduler = Rufus::Scheduler.new
#
# scheduler.every  '30s'  do  #每30秒执行一次任务一次
#
# end
#
# scheduler.in '10m' do  #在10分钟以后执行一次任务
#
# end
#
# scheduler.interval '5h' do  #每隔5小时执行一次
#
# end
#
# scheduler.at '2030/12/12 23:30:00' do #在2030/12/12 23:30:00执行一次任务
#
# end
#
# scheduler.cron '00 08 * * *' do  #每天早上8点执行一次任务
#
# end
