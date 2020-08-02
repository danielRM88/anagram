def is_anagram(str1, str2):
    if type(str1) != str or type(str2) != str:
        return False

    len1 = len(str1)
    len2 = len(str2)

    if len1 != len2:
        return False

    str1 = str1.lower()
    str2 = str2.lower()
    count = {}

    for i in range(len1):
        if count.get(str1[i]) == None:
            count[str1[i]] = 0

        if count.get(str2[i]) == None:
            count[str2[i]] = 0

        count[str1[i]] += 1
        count[str2[i]] -= 1

    for value in count.values():
        if value != 0:
            return False

    return True
