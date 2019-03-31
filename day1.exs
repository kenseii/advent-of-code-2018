defmodule Day1 do

  # Read the lines as strings, change them to a list of strings
  # change the list of strings to a list of ints then get the sum

  def final_frequency(input) do
    # input read from the file
    input
    |> String.split("\n", trim: true)
    |> sum_lines(0)
  end

  defp sum_lines([line | lines], current_frequency) do
    new_frequency = String.to_integer(line) + current_frequency
    sum_lines(lines, new_frequency)
  end

  # in case we have an empty list
  defp sum_lines([], current_frequency) do
    current_frequency
  end

end

# only run the tests if i a pass the --test flag

case System.argv() do
  ["--test"] ->
    # Tests of Day1

    ExUnit.start()

    defmodule Day1Test do

      import Day1

      use ExUnit.Case
      test "verify the final frequency" do
        assert final_frequency("""
          +7
          +8
          -8
          """) == 7

      end
    end
  # in case the input file is supplied
  [input_file] ->
      input_file
      |> File.read!()
      |> Day1.final_frequency()
      |> IO.puts()

  # in any other case
  _ ->
    IO.puts(:stderr, "we expected either --test or the input file")
    System.halt(1)
end

