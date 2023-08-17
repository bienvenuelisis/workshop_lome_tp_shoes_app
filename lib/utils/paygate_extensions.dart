import 'package:flutter_paygateglobal/flutter_paygateglobal.dart';

extension NewTransactionResponseStatusEnhancement
    on NewTransactionResponseStatus {
  String get label {
    switch (this) {
      case NewTransactionResponseStatus.success:
        return "Initialisation effectuée avec succès.";

      case NewTransactionResponseStatus.invalidToken:
        return "Jeton d’authentification invalide.";

      case NewTransactionResponseStatus.invalidParameters:
        return "Paramètres invalides.";

      case NewTransactionResponseStatus.identierExists:
        return "Doublons détectés. Une transaction avec le même identifiant existe déja.";

      case NewTransactionResponseStatus.cantLaunchPage:
        return "Impossible d’ouvrir la page de paiement.";

      default:
        return "Inconnu";
    }
  }
}

extension TransactionStatusEnhancement on TransactionStatus {
  String get label {
    switch (this) {
      case TransactionStatus.done:
        return "Paiement effectué avec succès.";

      case TransactionStatus.canceled:
        return "Paiement annulé.";

      case TransactionStatus.expired:
        return "Paiement expiré.";

      case TransactionStatus.waiting:
        return "Paiement en attente.";

      case TransactionStatus.none:
        return "Aucun paiement effectué.";

      default:
        return "Inconnu";
    }
  }
}
