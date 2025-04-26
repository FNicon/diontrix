local arrayPos = require ("extensions.arrayPos")
local matrixPos = require ("extensions.matrixPos")

---@class matrix
local matrix = {}

---- new ----

--- n dimension matrix
--- ```lua
--- --- column, row, page, etc
--- local matrix3D = matrix:new(2, 2, 2)
--- ```
---@param ... number
---@return matrix
function matrix:new(...)
    local length = select("#", ...)
    self.max = {}
    for i = 1, length do
        local val = select(i, ...)
        if type(val) ~= "number" then
            error("params should have type of number, instead got " .. val)
        end
        self.max[i] = val
    end
    self.data = {}

    setmetatable(self, {
        __tostring = function(table)
            local composite = ""
            for i = 1, self:len() do
                local matPos = table:matrixPos(i)
                composite = composite .. "(" .. matrixPos.matrixPosToString(matPos, table:dimension()) .. ") : "
                if (table.data[i] == nil) then
                    composite = composite .. "0"
                else
                    composite = composite .. table.data[i]
                end
                if i < self:len() then
                    composite = composite .. "\n"
                end
            end
            return composite
        end
    })
    return self
end

--- retrieve dimension count of the matrix
--- @return integer dimensionCount dimension count of the matrix
function matrix:dimension()
    return #self.max
end

--- get notation of matrix size dimension eg: (2, 2, 2)
--- @return string sizeNotation notation of matrix size eg: (2,2,2)
function matrix:sizeToString()
    return matrixPos.matrixPosToString(self.max, self:dimension())
end

--- retrieve length of the array where matrix is stored
--- @return integer arrayLength length of array
function matrix:len()
    if (self:dimension() == 0) then
        return 0
    else
        local len = 1
        for i = 1, self:dimension() do
            len = len * self.max[i]
        end
        return len
    end
end

--- retrieve array pos from matrix notation
--- @param ... number matrix position eg: (2, 2, 2)
--- @return number arrayPosition position on the array eg: 2
function matrix:idx(...)
    local elementCount = select("#", ...)
    if (elementCount == 0) then
        error("no arguments is given")
    else
        return arrayPos.arrayPos({...}, self.max)
    end
end

--- retrieve matrix notation position from array position
--- @param arrPos number position on the array eg: 8
--- @return table matrixPosition position on the matrix notation eg: (2, 2, 2)
function matrix:matrixPos(arrPos)
    local matPos = matrixPos.initialMatrixPos(self:dimension())
    return matrixPos.searchMatrixPos(matPos, arrPos, self.max)
end

--- set value based on matrix position
--- @param matPos table position on the matrix notation eg: (2, 2, 2)
--- @param val any value to be set on the matrix
function matrix:setOnMatrixPos(matPos, val)
    local idx = arrayPos.arrayPos(matPos, self.max)
    self.data[idx] = val
end

--- set value based on array position
--- @param arrayPos number position on the array position eg: 2
--- @param val any value to be set on the matrix
function matrix:setOnArrayPos(arrayPos, val)
    self.data[arrayPos] = val
end

return matrix