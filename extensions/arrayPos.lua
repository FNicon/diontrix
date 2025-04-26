local utils = {}

--- convert position of N Dimension Matrix eg: {1, 1, 1}
--- to positon of Array eg: 1
--- @param matrixPos table position on N Matrix notation eg: {2, 1, 1}
--- @param maxNDimension table max members on each N Matrix dimension eg: {2, 2, 2}
--- @return number arrayPos position on stored array eg: 2
function utils.arrayPos(matrixPos, maxNDimension)
    local result = 0
    local dimensionSizeMultiplier = 1
    for i = 1, #matrixPos do
        local dimensionIdx = matrixPos[i]
        -- x1 + (x2-1).size dim 1 + (x3-1). (size dim 1 x size dim 2) + (x4-1) (size dim 1 x dim 2 x dim 3) + ... etc
        if (i == 1) then
            result = result + dimensionIdx
        else
            result = result + (dimensionIdx - 1) * (dimensionSizeMultiplier)
        end
        dimensionSizeMultiplier = dimensionSizeMultiplier * maxNDimension[i]
    end
    return result
end

return utils