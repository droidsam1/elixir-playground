defmodule SimpleRegistry do

def start_link() do

  {:ok, self()}

end

end
