defmodule Todolist.SchemaTest do
  use Todolist.DataCase

  alias Todolist.Schema

  describe "user" do
    alias Todolist.Schema.Users

    import Todolist.SchemaFixtures

    @invalid_attrs %{}

    test "list_user/0 returns all user" do
      users = users_fixture()
      assert Schema.list_user() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Schema.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      valid_attrs = %{}

      assert {:ok, %Users{} = users} = Schema.create_users(valid_attrs)
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      update_attrs = %{}

      assert {:ok, %Users{} = users} = Schema.update_users(users, update_attrs)
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_users(users, @invalid_attrs)
      assert users == Schema.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Schema.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Schema.change_users(users)
    end
  end

  describe "user" do
    alias Todolist.Schema.Users

    import Todolist.SchemaFixtures

    @invalid_attrs %{email: nil, username: nil}

    test "list_user/0 returns all user" do
      users = users_fixture()
      assert Schema.list_user() == [users]
    end

    test "get_users!/1 returns the users with given id" do
      users = users_fixture()
      assert Schema.get_users!(users.id) == users
    end

    test "create_users/1 with valid data creates a users" do
      valid_attrs = %{email: "some email", username: "some username"}

      assert {:ok, %Users{} = users} = Schema.create_users(valid_attrs)
      assert users.email == "some email"
      assert users.username == "some username"
    end

    test "create_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_users(@invalid_attrs)
    end

    test "update_users/2 with valid data updates the users" do
      users = users_fixture()
      update_attrs = %{email: "some updated email", username: "some updated username"}

      assert {:ok, %Users{} = users} = Schema.update_users(users, update_attrs)
      assert users.email == "some updated email"
      assert users.username == "some updated username"
    end

    test "update_users/2 with invalid data returns error changeset" do
      users = users_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_users(users, @invalid_attrs)
      assert users == Schema.get_users!(users.id)
    end

    test "delete_users/1 deletes the users" do
      users = users_fixture()
      assert {:ok, %Users{}} = Schema.delete_users(users)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_users!(users.id) end
    end

    test "change_users/1 returns a users changeset" do
      users = users_fixture()
      assert %Ecto.Changeset{} = Schema.change_users(users)
    end
  end

  describe "workingtimes" do
    alias Todolist.Schema.Workingtime

    import Todolist.SchemaFixtures

    @invalid_attrs %{end: nil, start: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      workingtime = workingtime_fixture()
      assert Schema.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      workingtime = workingtime_fixture()
      assert Schema.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      valid_attrs = %{end: ~U[2022-10-25 12:45:00Z], start: ~U[2022-10-25 12:45:00Z]}

      assert {:ok, %Workingtime{} = workingtime} = Schema.create_workingtime(valid_attrs)
      assert workingtime.end == ~U[2022-10-25 12:45:00Z]
      assert workingtime.start == ~U[2022-10-25 12:45:00Z]
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_workingtime(@invalid_attrs)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      workingtime = workingtime_fixture()
      update_attrs = %{end: ~U[2022-10-26 12:45:00Z], start: ~U[2022-10-26 12:45:00Z]}

      assert {:ok, %Workingtime{} = workingtime} = Schema.update_workingtime(workingtime, update_attrs)
      assert workingtime.end == ~U[2022-10-26 12:45:00Z]
      assert workingtime.start == ~U[2022-10-26 12:45:00Z]
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      workingtime = workingtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Schema.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{}} = Schema.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      workingtime = workingtime_fixture()
      assert %Ecto.Changeset{} = Schema.change_workingtime(workingtime)
    end
  end

  describe "clocks" do
    alias Todolist.Schema.Clock

    import Todolist.SchemaFixtures

    @invalid_attrs %{status: nil, time: nil}

    test "list_clocks/0 returns all clocks" do
      clock = clock_fixture()
      assert Schema.list_clocks() == [clock]
    end

    test "get_clock!/1 returns the clock with given id" do
      clock = clock_fixture()
      assert Schema.get_clock!(clock.id) == clock
    end

    test "create_clock/1 with valid data creates a clock" do
      valid_attrs = %{status: true, time: ~U[2022-10-25 13:17:00Z]}

      assert {:ok, %Clock{} = clock} = Schema.create_clock(valid_attrs)
      assert clock.status == true
      assert clock.time == ~U[2022-10-25 13:17:00Z]
    end

    test "create_clock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_clock(@invalid_attrs)
    end

    test "update_clock/2 with valid data updates the clock" do
      clock = clock_fixture()
      update_attrs = %{status: false, time: ~U[2022-10-26 13:17:00Z]}

      assert {:ok, %Clock{} = clock} = Schema.update_clock(clock, update_attrs)
      assert clock.status == false
      assert clock.time == ~U[2022-10-26 13:17:00Z]
    end

    test "update_clock/2 with invalid data returns error changeset" do
      clock = clock_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_clock(clock, @invalid_attrs)
      assert clock == Schema.get_clock!(clock.id)
    end

    test "delete_clock/1 deletes the clock" do
      clock = clock_fixture()
      assert {:ok, %Clock{}} = Schema.delete_clock(clock)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_clock!(clock.id) end
    end

    test "change_clock/1 returns a clock changeset" do
      clock = clock_fixture()
      assert %Ecto.Changeset{} = Schema.change_clock(clock)
    end
  end
end
