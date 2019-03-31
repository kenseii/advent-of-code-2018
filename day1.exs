defmodule Day1 do

  # Read the lines as strings, change them to a list of strings
  # change the list of strings to a list of ints then get the sum

  def final_frequency(input) do
    # input read from the file
    input
    |> Enum.map(fn line ->
      {integer, _leftover} = Integer.parse(line)
      integer end)
    |> Stream.cycle()
    |> Enum.reduce_while({0, [0]}, fn x, {current_frequency, seen_frequencies} ->
      new_frequency = current_frequency + x
      if new_frequency in seen_frequencies do
        {:halt, new_frequency}
      else
        {:cont, {new_frequency, [new_frequency | seen_frequencies]}}
      end
    end )
  end

end
# only run the tests if i a pass the --test flag, receive input file as a flag, and in case there is no input show a message

case System.argv() do
  ["--test"] ->
    # Tests of Day1

    ExUnit.start()

    defmodule Day1Test do
      use ExUnit.Case
      import Day1

      test "verify the final frequency" do
        assert final_frequency([
        "+1\n",
        "-2\n",
        "+3\n",
        "+1\n"
        ]) == 2

      end
    end
  # in case the input file is supplied
  [input_file] ->
      input_file
      # read the file line by line instead of loading everything in the memory
      |> File.stream!([], :line)
      |> Day1.final_frequency()
      |> IO.puts()

  # in any other case
  _ ->
    IO.puts(:stderr, "we expected either --test or the input file")
    System.halt(1)
end

