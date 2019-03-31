defmodule Day1 do

  # Read the lines as strings, change them to a list of strings
  # change the list of strings to a list of ints then get the sum

  def final_frequency(input) do
    # input read from the file
    input
    |> Stream.map(fn line ->
      {integer, _leftover} = Integer.parse(line)
      integer end)
    |> Enum.sum()
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
        # build an io device to be read as a file
        {:ok, io} = StringIO.open("""
        +7
        +8
        -8
        """)
        # load the io as a stream and check the value
        assert final_frequency(IO.stream(io, :line)) == 7

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

