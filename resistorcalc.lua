--[[
	한글로 된 저항값 계산기
]]--


--[[
색 첫 번째 띠   두 번째 띠   세 번째 띠 (단위)   4번째 띠 (오차)    열계수

검정 	0 0 ×10^0     
갈색 	1 1 ×10^1 	±1% (F) 		100 ppm 
빨강색 	2 2 ×10^2 	±2% (G) 		50 ppm 
주황색 	3 3 ×10^3   				15 ppm 
노랑색 	4 4 ×10^4   				25 ppm 
초록색 	5 5 ×10^5 	±0.5% (D)   
파랑색 	6 6 ×10^6 	±0.25% (C)   
보라색 	7 7 ×10^7 	±0.1% (B)   
회색 	8 8 ×10^8 	±0.05% (A)   
흰색 	9 9 ×10^9     
금색     	×0.1 	±5% (J)   
은색     	×0.01 	±10% (K)   
없음       			±20% (M)   
]]--

first_second_band	= {
	['검'] = 0,
	['갈'] = 1,
	['적'] = 2,
	['주'] = 3,
	['노'] = 4,
	['초'] = 5,
	['파'] = 6,
	['보'] = 7,
	['회'] = 8,
	['흰'] = 9
}


-- 10 * value
third_band	= {
	['검'] = '1',
	['갈'] = '10',
	['적'] = '100',
	['주'] = '1K',
	['노'] = '10K',
	['초'] = '100K',
	['파'] = '1M',
	['보'] = '10M',
	['회'] = '100M',
	['흰'] = '1G',
	['금'] = '0.01',
	['은'] = '0.001'
}

fourth_band	= {
	['갈'] = '±1%',
	['적'] = '±2%',
	['초'] = '±0.5%',
	['파'] = '±0.25%',
	['보'] = '±0.1%',
	['회'] = '±0.05%',
	['금'] = '±5%',
	['은'] = '±10%',
	['무'] = '±20%'
}

-- 열계수
fifth_second_band	= {
	['갈'] = 100,
	['적'] = 50,
	['주'] = 15,
	['노'] = 25
}


function CalcResistorColor(user_id, arg)
	local arr = UTF8ToCharArray(arg);

	local result = ''

	-- 첫번째 띄
	if ( first_second_band[arr[1]] == nil ) then	
		return "첫번째 띄 오류"
	else
		result = tostring(first_second_band[arr[1]])
	end

	-- 두번째 띄
	if ( first_second_band[arr[2]] == nil ) then	
		return "두번째 띄 오류"
	else
		result = result .. tostring(first_second_band[arr[2]])
	end

	-- 세번째 띄
	if ( third_band[arr[3]] == nil ) then	
		return "세번째 띄 오류"
	else
		result = result .. ' x ' .. third_band[arr[3]]
	end

	-- 네번째 띄
	if ( fourth_band[arr[4]] == nil ) then	
		return "네번째 띄 오류"
	else
		result = result .. '  ' .. tostring(fourth_band[arr[4]])
	end

	result = '저항값 : ' .. result

	send_msg(user_id, result, ok_cb, false)

end

