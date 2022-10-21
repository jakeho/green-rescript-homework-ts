module Stare = %relay(`
  mutation StarButtonAddMutation($input: AddStarInput!) {
    addStar(input: $input) {
      clientMutationId
      starrable {
        id
        stargazerCount
        viewerHasStarred
      }
    }
  }
`)

module UnStare = %relay(`
  mutation StarButtonRemoveMutation($input: RemoveStarInput!) {
    removeStar(input: $input) {
      clientMutationId
      starrable {
        id
        stargazerCount
        viewerHasStarred
      }
    }
  }
`)

@react.component
let make = (~count: int, ~starred: bool, ~id: string) => {
  let (addMutate, isAddMutate) = Stare.use()
  let (removeMutate, isRemoveMutate) = UnStare.use()

  let onClickStar = _ => {
    if !starred {
      addMutate(
        ~variables={
          input: {
            clientMutationId: None,
            starrableId: id,
          },
        },
        (),
      )->ignore
    } else {
      removeMutate(
        ~variables={
          input: {
            clientMutationId: None,
            starrableId: id,
          },
        },
        (),
      )->ignore
    }
  }

  open Belt
  <button
    className="button border border-1 rounded p-1 px-2 self-center inline-flex items-center disabled:text-gray-400"
    onClick={onClickStar}
    disabled={isAddMutate || isRemoveMutate}>
    <i className="material-icons text-base mr-1">
      {starred ? "star"->React.string : "star_border"->React.string}
    </i>
    <span> {count->Int.toString->React.string} </span>
  </button>
}
