--[[
	Triangle generator

	Generates randomized triangles that follow a specific format.
	There are 6 distinct triangles that can be drawn and 4 rotations for each triangle.

	1. Right triangle
	2. Isosceles triangle
	3. A triangle with flat bottom and a point to the left
	4. A triangle with flat left with a point downwards
	5. Two points on a diagonal line and a point inside the circle surrounding the two points
	6. Two points on a diagonal line and a point outside the circle surrounding the two points

	Triangle 5 and 6 does not have a flat bottom or side

	This script will generate a uniform set of triangles belonging to the 6 types
]]

local M = {}

local TRIANGLE_TYPES = {
	{ { x = 1, y = 0 }, { x = 0.5,  y = 0    }, { x = 0,   y = 1   } }, -- Flat bottom
	{ { x = 1, y = 0 }, { x = 0,    y = 0    }, { x = 0.5, y = 1   } }, -- Flat bottom 
	{ { x = 1, y = 0 }, { x = 0,    y = 0    }, { x = 0,   y = 1   } }, -- Flat bottom / left
	{ { x = 1, y = 0 }, { x = 0,    y = 0.5  }, { x = 0,   y = 1   } }, -- Flat left
	{ { x = 1, y = 0 }, { x = 0.29, y = 0.29 }, { x = 0,   y = 1   } }, 
	{ { x = 0, y = 0 }, { x = 0.5,  y = 1    }, { x = 1,   y = 0.5 } },
}

--- Generate a specific type of triangle
--- 
--- @param triangle_type  integer the type of triangle
--- @param rotation_index integer the rotation, 0 1 2 or 3
--- @param width          integer the output width
--- @param height         integer the output height
--- @param x_offset       integer the x coordinate offset
--- @param y_offset       integer the y coordinate offset
---
--- @return table triangles a single triangle
function M.generate_single(triangle_type, rotation_index, width, height, x_offset, y_offset)
	triangle_type = math.floor(math.max(1, math.min(6, triangle_type)))

	-- Max offset
	local max_offset = 0.24
	local multiplier = 1 / (2 * max_offset + 1)

	local triangle = TRIANGLE_TYPES[triangle_type]
	local x1 = math.random() * max_offset
	local y1 = math.random() * max_offset
	local x2 = math.random() * max_offset
	local y2 = math.random() * max_offset
	local x3 = math.random() * max_offset
	local y3 = math.random() * max_offset

	if triangle_type == 1 or triangle_type == 2 or triangle_type == 3 then
		-- Keep bottom flat
		y2 = y1
	end

	if triangle_type == 3 or triangle_type == 4 then
		-- Keep left flat
		x3 = x2
	end

	local function rotate_scale_point(x, y)
		local s = math.sin(math.rad(90 * rotation_index))
		local c = math.cos(math.rad(90 * rotation_index))
		local px = x - 0.5
		local py = y - 0.5
		local rpx = px * c - py * s
		local rpy = px * s + py * c
		return {
			x = (rpx * multiplier + 0.5) * width + x_offset,
			y = (rpy * multiplier + 0.5) * height + y_offset
		}
	end

	return {
		rotate_scale_point(triangle[1].x + x1, triangle[1].y + y1),
		rotate_scale_point(triangle[2].x + x2, triangle[2].y + y2),
		rotate_scale_point(triangle[3].x + x3, triangle[3].y + y3),
	}
end

--- Generate random triangles that can be used for benchmarking
---
--- @param amount   integer  how many batches of 24 triangles to generate
--- @param width    integer  the maximum width of the triangles
--- @param height   integer  the maximum height of the triangles
--- @param x_offset integer? the x coordinate offset of the triangles
--- @param y_offset integer? the y coordinate offset of the triangles
---
--- @return table triangles an array of generated triangles
function M.generate(amount, width, height, x_offset, y_offset)
	local triangles = {}
	x_offset = x_offset or 0
	y_offset = y_offset or 0

	for i=1,amount*24 do
		local t_type     = ((i - 1) % 6) + 1
		local t_rotation = math.floor((i - 1) / 4) % 4
		triangles[#triangles + 1] = M.generate_single(t_type, t_rotation, width, height, x_offset, y_offset)
	end

	return triangles
end

return M
