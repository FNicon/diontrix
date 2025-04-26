local matrix = require("matrix")

local function testLen()
    print("test_len()")
    local m = matrix:new(2, 2, 2)
    print("testing size of matrix (".. m:sizeToString() ..") is equal to : " .. m:len())

    local expected = 2^3
    local actual = m:len()

    assert(actual == expected, "matrix of size {".. m:sizeToString() .."} does not equal to ".. expected)
end

local function testIdx()
    print("test_idx()")
    local m = matrix:new(2,1,2)
    print("testing index 2,1,2 from (".. m:sizeToString() ..") matrix", m:idx(2,1,2))
    local expected = 4
    local actual = m:idx(2,1,2)
    assert(actual == expected, "index 2,1,2 on matrix (".. m:sizeToString() ..") does not equal to ".. expected)

    local m2 = matrix:new(2,2,2)
    print("testing index 2,1,2 from (".. m2:sizeToString() ..") matrix", m2:idx(2,1,2))

    local expected2 = 6
    local actual2 = m2:idx(2,1,2)
    assert(actual2 == expected2, "index 2,1,2 on matrix (".. m2:sizeToString() ..") does not equal to "..expected2)

    local m3 = matrix:new(2,3,2)
    print("testing index 2,1,2 from (".. m3:sizeToString() ..") matrix", m3:idx(2,1,2))

    local expected3 = 8
    local actual3 = m3:idx(2,1,2)
    assert(actual3 == expected3, "index 2,1,2 on matrix (".. m3:sizeToString() ..") does not equal to "..expected3)
end

local function testTostring()
    print("test_tostring()")

    local m = matrix:new(2)
    print("1D Matrix size (".. m:sizeToString() ..")")
    print(m)
    local m2 = matrix:new(2,2)
    print("2D Matrix size (".. m2:sizeToString() ..")")
    print(m2)
    local m3 = matrix:new(2,2,2)
    print("3D Matrix size (".. m3:sizeToString() ..")")
    print(m3)
end

local function testMatrixPos()
    print("test_inflateIdx()")

    local m = matrix:new(2,2,2)
    local checkArrayPos = 3
    local matrixPos = m:matrixPos(checkArrayPos)

    local composite = ""
    for i = 1, #matrixPos do
        composite = composite .. (matrixPos[i])
        if (i < #matrixPos) then
            composite = composite .. ","
        end
    end

    print("on matrix (".. m:sizeToString() .."), flat Index " .. checkArrayPos .. " is located on " .. "(" .. composite ..")")
end

local function testSetOnArrayPos()
    print("testSetOnArrayPos()")
    local m = matrix:new(2,2,2)

    local arrayPos = 4
    local val = 4

    m:setOnArrayPos(arrayPos, val)

    print("on matrix (".. m:sizeToString() .."), set " .. val .. " on array pos : " .. arrayPos )

    print(m)
end

local function testSetOnMatrixPos()
    print("testSetOnMatrixPos()")
    local m = matrix:new(2,2,2)

    local matrixPos = {2,1,2}
    local val = 4

    m:setOnMatrixPos(matrixPos, val)

    print("on matrix (".. m:sizeToString() .."), set " .. val .. " on matrix pos : " .. "(2,1,2)" )

    print(m)
end

testLen()
testIdx()
testTostring()
testMatrixPos()
testSetOnArrayPos()
testSetOnMatrixPos()