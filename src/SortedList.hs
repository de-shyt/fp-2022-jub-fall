{-# LANGUAGE InstanceSigs #-}
module SortedList where

-- Тип данных, представляющий собой отсортированный список
data SortedList a = SortedList { getSortedList :: [a] }
                  deriving (Show, Eq)

-- <> должен сохранять отсортированность списка
instance Ord a => Semigroup (SortedList a) where
  (<>) :: SortedList a -> SortedList a -> SortedList a
  (<>) list1 list2 = SortedList {
    getSortedList = mergeLists (getSortedList list1) (getSortedList list2)
  } where
    mergeLists first [] = first
    mergeLists [] second = second
    mergeLists (x : xs) (y : ys) =
        if (x < y) then x : (mergeLists xs (y : ys))
        else y : (mergeLists (x : xs) ys)

instance Ord a => Monoid (SortedList a) where
  mempty :: SortedList a
  mempty = SortedList { getSortedList = [] }