||| Testing Queues
module Test.DependentAVL.Dict

import Test.Harness
import Data.AVL.Dependent.Dict

-- ------------------------------------------------------------ [ Construction ]

testBuilding : Test (List (Int, Int))
testBuilding = MkTest
    (Just "List, Building" )
    (Dict.toList $ Dict.fromList [(1,2), (2,3), (3,4)])
    [(1,2), (2,3), (3,4)]
    (==)


-- ---------------------------------------------------------------- [ Updating ]
partial
testUpdate : Test (List (Int, Int))
testUpdate = MkTest
    (Just "Update")
    (Dict.toList $ Dict.update 2 (*2) $ Dict.fromList [(1,2), (2,3), (3,4), (5,3)])
    [(1,2), (2,6), (3,4), (5,3)]
    (==)

partial
testHas : Test (Bool)
testHas = MkTest
   (Just "Has value")
   (hasValue 6 $ Dict.fromList [(1,2), (2,6), (3,4)])
   (True)
   (==)

-- ----------------------------------------------------------------- [ Queries ]
partial
testLookup : Test (Maybe Int)
testLookup = MkTest
    (Just "Lookup")
    (Dict.lookup 1 $ Dict.fromList [(1,2), (2,3), (3,4)])
    (Just 2)
    (==)

partial
testKVs : Test (List Int, List Int)
testKVs = MkTest
    (Just "KV Pair Extraction")
    (keys given, values given)
    ([1,2,3], [5,6,7])
    (==)
  where
    given : Dict Int Int
    given = Dict.fromList [(1,5), (2,6), (3,7)]

partial
runTest : IO ()
runTest = do
  putStrLn "Testing Dict"
  putStrLn infoLine
  runTests [
      testRunner testBuilding
    , testRunner testLookup
    , testRunner testUpdate
    , testRunner testHas
    , testRunner testKVs
  ]

-- --------------------------------------------------------------------- [ EOF ]
