defmodule Hashcode2020.Pizza do
  def solve do
    n = Hashcode2020.Pizza.IO.read_header(:stdio)
    pizzas = Hashcode2020.Pizza.IO.read_pizzas(:stdio)
    orders = solve(pizzas, n)
    Hashcode2020.Pizza.IO.put_types(:stdio, orders)
    Hashcode2020.Pizza.IO.put_orders(:stdio, orders)
  end

  def solve(pizzas, n) do
    pizzas
    |> Enum.with_index()
    |> Enum.sort()
    |> Enum.reverse()
    |> do_solve(n)
  end

  defp do_solve(pizzas, n, m \\ 0, acc \\ [])

  defp do_solve([{pizza, idx} | rest], n, m, acc) when n >= m + pizza do
    do_solve(rest, n, pizza + m, [idx | acc])
  end

  defp do_solve([_ | rest], n, m, acc) do
    do_solve(rest, n, m, acc)
  end

  defp do_solve([], _, _, acc) do
    acc
  end
end

defmodule Hashcode2020.Pizza.IO do
  def read_header(device) do
    IO.read(device, :line)
    |> String.split()
    |> List.first()
    |> String.to_integer()
  end

  def read_pizzas(device) do
    IO.read(device, :line)
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  def put_types(device, orders) do
    orders
    |> length()
    |> IO.puts(device)
  end

  def put_orders(device, orders) do
    orders
    |> Enum.intersperse(" ")
    |> Enum.map(&to_string/1)
    |> IO.puts(device)
  end
end
