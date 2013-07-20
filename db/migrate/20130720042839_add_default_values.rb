class AddDefaultValues < ActiveRecord::Migration
  def up
    Topic.update_all({ locked: false }, { locked: nil })
    Topic.update_all({ sticky: false }, { sticky: nil })
    User.update_all({ admin: false }, { admin: nil })

    change_column_default :topics, :locked, false
    change_column_default :topics, :sticky, false
    change_column_default :users, :admin, false

    change_column_null :topics, :locked, false
    change_column_null :topics, :sticky, false
    change_column_null :users, :admin, false
  end

  def down
    change_column_null :topics, :locked, true
    change_column_null :topics, :sticky, true
    change_column_null :users, :admin, true

    change_column_default :topics, :locked, nil
    change_column_default :topics, :sticky, nil
    change_column_default :users, :admin, nil
  end
end
