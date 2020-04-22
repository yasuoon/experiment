defmodule Communication.Crc16 do
  def calc(bin) do
    :binary.bin_to_list(bin)
    |> Enum.reduce(0xFFFF, fn n, acc ->
      Bitwise.bxor(n, acc) |> calc_byte
    end)
    |> crc_to_bin
  end

  defp calc_byte(crc) do
    Enum.reduce(1..8, crc, fn _, acc ->
      right_shift1(acc)
    end)
  end

  defp right_shift1(n)  do
    chk_carry(n, Bitwise.bsr(n, 1))
  end

  defp chk_carry(n, shifted) do
    case Bitwise.band(n, 1) do
      1 -> Bitwise.bxor(shifted, 0xA001)
      _ -> shifted
    end
  end

  defp crc_to_bin(crc) do
    :binary.list_to_bin([rem(crc, 256), div(crc, 256)])
  end
end
