# require 'togglv8'
# require 'net/http'
# require 'JSON'
#
# class TogglHandler
#   API_TOKEN = '4a4cd019eeda410699604ee008c032d8'
#   WORKSPACE_ID = '433182'
#   BASE_URL = 'https://toggl.com/reports/api/v2/details'
#
#   CLIENT_IDS = {
#     iManage: 4255270,
#     iTank: 8707508,
#     ys: 11291097,
#     yoyoblox: 9713051
#   }
#
#   def self.get_entry
#     uri = URI(
#             "#{BASE_URL}?" +
#             "workspace_id=#{WORKSPACE_ID}&" +
#             "since=#{(Date.today.beginning_of_week(:monday) - 1.week).to_s}&" +
#             "until=#{(Date.today.beginning_of_week(:monday) - 1.day).to_s}&" +
#             "user_agent=gabriel.fagundez@moove-it.com" +
#             # "billable=yes" +
#             # "project_ids=#{CLIENT_IDS.values.join(',')}" +
#             "display_hours=decimal"
#     )
#
#     req = Net::HTTP::Get.new(uri)
#     req.basic_auth API_TOKEN, 'api_token'
#
#     http = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true)
#     resp = http.request(req)
#
#     p '======================='
#     puts resp.body
#     p '======================='
#   end
#
# end
