class Solution:
    def generateParenthesis(self, n: int) -> list[str]:
        combinaisons = [*[range(i, i % n) for i in range(n)], range(4, 0)]
