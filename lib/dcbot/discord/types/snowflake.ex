defmodule Dcbot.Discord.Types.Snowflake do
  @behaviour Ecto.Type

  @uint64min 0
  @uint64max 18_446_744_073_709_551_615

  @int64min -9_223_372_036_854_775_808
  @int64max 9_223_372_036_854_775_807

  @uint64_to_int64_shift 9_223_372_036_854_775_808

  @discod_epoch 1_420_070_400_000

  defstruct timestamp: nil,
            internal_worker_id: nil,
            internal_process_id: nil,
            increment: nil

  def type, do: :bigint

  def cast(nil), do: {:ok, nil}

  def cast(snowflake)
      when is_integer(snowflake) and @uint64min <= snowflake and snowflake <= @uint64max,
      do: {:ok, snowflake}

  def cast(_), do: :error

  def to_struct(snowflake)
      when is_integer(snowflake) and @uint64min <= snowflake and snowflake <= @uint64max do
    alias Dcbot.Discord.Types.Snowflake

    <<timestamp::42, internal_worker_id::5, internal_process_id::5, increment::12>> =
      <<snowflake::64>>

    timestamp = DateTime.from_unix!(timestamp + @discod_epoch, :millisecond)

    %Snowflake{
      timestamp: timestamp,
      internal_worker_id: internal_worker_id,
      internal_process_id: internal_process_id,
      increment: increment
    }
  end

  def dump(nil), do: {:ok, nil}

  def dump(snowflake)
      when is_integer(snowflake) and @uint64min <= snowflake and snowflake <= @uint64max,
      do: {:ok, snowflake - @uint64_to_int64_shift}

  def dump(_), do: :error

  def load(nil), do: {:ok, nil}

  def load(snowflake)
      when is_number(snowflake) and @int64min <= snowflake and snowflake <= @int64max,
      do: {:ok, snowflake + @uint64_to_int64_shift}

  def load(_), do: :error
end
