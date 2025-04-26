local arrayPos = require("extensions.arrayPos")

local utils = {}

--- get initial position of N Dimension Matrix eg: {1,1,1}
--- @param dimensionCount number dimension Count of N Dimension Matrix eg: 3
--- @return table initialPos initial position of N Dimension Matrix eg: {1,1,1}
function utils.initialMatrixPos(dimensionCount)
    local matrixPos = {}
    for i =1, dimensionCount do
        table.insert(matrixPos, 1)
    end
    return matrixPos
end

--- get next position of N Dimension Matrix eg: {1,1,1} to {2,1,1} or {1, 2, 1} to {1, 1, 2} on { 2, 2, 2 } 3D matrix
--- @param matrixPos number position notation on matrix eg: {1, 1, 1}
--- @param checkDimension number dimension to check eg: 2
--- @param maxNDimension number max members on each N Matrix dimension eg: {2, 2, 2}
--- @return any
function utils.recursiveNextMatrixPos(matrixPos, checkDimension, maxNDimension)
    -- checked outside dimension count, reached end
    if (checkDimension > #maxNDimension) then
        return matrixPos
    else
        local nextMatrixPos = matrixPos
        -- eg: check on dimension 1, change (1,1,1) to (2,1,1)
        if nextMatrixPos[checkDimension] < maxNDimension[checkDimension] then
            nextMatrixPos[checkDimension] = nextMatrixPos[checkDimension] + 1
            return nextMatrixPos
        else
            -- change dimension
            -- eg: on matrix 2*2*2, change (2,1,1) to (1,2,1)
            -- eg: on matrix 2*2*2, change (2,2,1) to (1,1,2)
            if (checkDimension + 1 <= #maxNDimension) then
                for i = checkDimension, 1, -1 do
                    nextMatrixPos[i] = 1
                end
                return utils.recursiveNextMatrixPos(nextMatrixPos, checkDimension + 1, maxNDimension)
            -- eg: on matrix 2*2*2, check dimension 3, change (1,1,2) to (2,1,2)
            else
                return utils.recursiveNextMatrixPos(nextMatrixPos, 1, maxNDimension)
            end
        end
    end
end

function utils.nextMatrixPos(matrixPos, maxNDimension)
    return utils.recursiveNextMatrixPos(matrixPos, 1, maxNDimension)
end

function utils.searchMatrixPos(matrixPos, seekArrayPos, maxNDimension)
    local newArrayPos = arrayPos.arrayPos(matrixPos, maxNDimension)
    if (seekArrayPos > newArrayPos) then
        local nextIdx = utils.nextMatrixPos(matrixPos, maxNDimension)
        return utils.searchMatrixPos(nextIdx, seekArrayPos, maxNDimension)
    else
        return matrixPos
    end
end

function utils.matrixPosToString(matrixPos, dimensionCount)
    local composite = ""
    for i = 1, dimensionCount do
        composite = composite .. matrixPos[i]
        if (i < dimensionCount) then
            composite = composite .. ","
        end
    end
    composite = composite .. ""
    return composite
end

return utils