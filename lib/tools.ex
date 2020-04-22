defmodule Tools do
  @moduledoc """
  汎用的に使う関数群
  """

  @doc """
  * 関数名     : zeropad
  * 機能       : 正の整数値を指定した桁数の文字列で返す  
  *              このとき先頭から"0"で埋める
  * 前提条件   :
  * 引数       : i (integer)  文字列に変換する正の整数値  
  *              digits (integer) 桁数  
  *              base (integer) 基数, 2-36進数を指定, デフォルトは10進数
  * 戻り値     : (binary) 数値を変換した文字列
  * 最終修正日 : 2020-04-21
  * 最終修正者 : Yasuo Oono
  """
  def zeropad(i, digits, base \\ 10) do
    Integer.to_string(i, base)
    |> String.pad_leading(digits, "0")
  end
end
