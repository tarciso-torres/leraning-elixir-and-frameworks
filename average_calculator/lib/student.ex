defmodule Student do
    @moduledoc """
    Define a Student struct and functions to handle a student.
    """

    defstruct name: nil, results: []

    @doc """
    Get the first name of a Student.

    ## Parameters
    - `student`- A student struct.

    ## Examples

    * joao = %Student{name: "João Joaquim"}
    * Student.firs_name(joao)
    * "João"
    """
    def first_name(name) do
        name
        |> String.split
        |> List.first
    end

    @doc """
    Get the last nameof a student.

    ## Parameters
    - `student`- A student struct.

    ## Examples

    * joao = %Student{name: "João Joaquim"}
    * Student.firs_name(joao)
    * "Joaquim"
    """
    def last_name(name) do
        name
        |> String.split
        |> List.last
    end
end