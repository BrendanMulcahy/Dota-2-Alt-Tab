local dota_versions = {
  {'6.71' , os.time{day=21, month=01, year=2011}},
  {'6.71b', os.time{day=23, month=01, year=2011}},
  {'6.72' , os.time{day=27, month=04, year=2011}},
  {'6.72b', os.time{day=04, month=05, year=2011}},
  {'6.72c', os.time{day=03, month=06, year=2011}},
  {'6.72d', os.time{day=17, month=07, year=2011}},
  {'6.72e', os.time{day=18, month=07, year=2011}},
  {'6.72f', os.time{day=22, month=07, year=2011}},
  {'6.73' , os.time{day=24, month=12, year=2011}},
  {'6.73b', os.time{day=28, month=12, year=2011}},
  {'6.73c', os.time{day=10, month=01, year=2012}},
  {'6.74' , os.time{day=10, month=03, year=2012}},
  {'6.74b', os.time{day=20, month=03, year=2012}},
  {'6.74c', os.time{day=21, month=03, year=2012}},
  {'6.75' , os.time{day=30, month=09, year=2012}},
  {'6.75b', os.time{day=02, month=10, year=2012}},
}

local function date_to_dota_version(d)
  local guideDate = os.time(d)
  
  local curr_name, curr_time = 'Before 6.71', nil
  for _, dp in ipairs(dota_versions) do
    local next_name, next_time = dp[1], dp[2]
    if os.difftime(next_time, guideDate) >= 0 then
      return curr_name
    end
    curr_name, curr_time = next_name, next_time
  end
  return curr_name

end

return {
  fromDate = date_to_dota_version,
  versions = dota_versions,
}
