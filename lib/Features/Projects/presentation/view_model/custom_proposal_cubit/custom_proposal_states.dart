abstract class CustomProposalStates {}

class CustomProposalInitial extends CustomProposalStates {}

class CustomProposalLoading extends CustomProposalStates {}

class CustomProposalSuccess extends CustomProposalStates {
  final String proposal;
  CustomProposalSuccess({required this.proposal});
}

class CustomProposalFailure extends CustomProposalStates {
  final String errorMessage;
  CustomProposalFailure({required this.errorMessage});
}
