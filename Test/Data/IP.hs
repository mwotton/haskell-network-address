module Test.Data.IP (tests) where
import Data.IP
import Test.Framework
import Test.Framework.Providers.QuickCheck2
import Test.QuickCheck
import Test.QuickCheck.Arbitrary
import Data.List (intercalate)
import Data.Word

instance Arbitrary IPv4 where
    arbitrary = fmap (read . intercalate ".") . fmap (map show) $ vectorOf 4 (arbitrary :: Gen Word8)
--    arbitrary = ipv4 arbitrary arbitrary arbitrary arbitrary
--        where ipv4 :: Word8 -> Word8 -> Word8 -> Word8 -> IPv4
--              ipv4 a b c d = intercalate "." . map show $ [a, b, c, d]

tests = [ testGroup "IPv4"
            [ testProperty "Symmetric Read/Show" prop_ipv4_symmetric_readable
            ]
        ]

prop_ipv4_symmetric_readable :: IPv4 -> Bool
prop_ipv4_symmetric_readable ip = (read . show) ip == id ip
