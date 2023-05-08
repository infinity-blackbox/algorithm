from .generate_parentheses import Solution


def test_solution():
    solver = Solution()
    assert solver.generateParenthesis(3) == [
        "((()))",
        "(()())",
        "(())()",
        "()(())",
        "()()()",
    ]
