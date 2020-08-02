from is_anagram import is_anagram

assert is_anagram("", "") == True
assert is_anagram("A", "A") == True
assert is_anagram("A", "B") == False
assert is_anagram("ab", "ba") == True
assert is_anagram("AB", "ab") == True
assert is_anagram("Alan Turing", "Natural Gin") == True
assert is_anagram("abcdefg", "gfedcba") == True
assert is_anagram(None, None) == False
assert is_anagram(None, "None") == False
assert is_anagram("None", None) == False
assert is_anagram("  ", "  ") == True
assert is_anagram("  ", " 1 ") == False
