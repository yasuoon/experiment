defmodule Communication.CheckSum do

  @doc """
  * 関数名     : calc
  * 機能       : 引数で与えられたバイナリのチェックサムを計算
  * 前提条件   :
  * 引数       : bin (binary) 
  * 戻り値     : (binary) 計算結果のバイナリ
  * 最終修正日 : 2020-04-19
  * 最終修正者 : Yasuo Oono

  ## Examples

      iex> Communication.CheckSum.calc(<<0>>)
      "00"

  """
  def calc(bin) do
    :binary.bin_to_list(bin)
    |> Enum.sum
    |> Bitwise.band(0xFF)
    |> Tools.zeropad(2, 16)
  end
end
