package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// SmartContract for asset registry
type SmartContract struct {
	contractapi.Contract
}

// Asset represents a digital asset stored on the blockchain
type Asset struct {
	AssetID string `json:"assetID"`
	Owner   string `json:"owner"`
	Type    string `json:"type"`
	Value   int    `json:"value"`
}

// RegisterAsset adds a new asset to the ledger
func (s *SmartContract) RegisterAsset(
	ctx contractapi.TransactionContextInterface,
	assetID string,
	owner string,
	assetType string,
	value int,
) error {

	// Check if asset already exists
	existingAsset, err := ctx.GetStub().GetState(assetID)
	if err != nil {
		return fmt.Errorf("failed to read asset from ledger: %v", err)
	}

	if existingAsset != nil {
		return fmt.Errorf("asset %s already exists", assetID)
	}

	// Create asset object
	asset := Asset{
		AssetID: assetID,
		Owner:   owner,
		Type:    assetType,
		Value:   value,
	}

	// Convert to JSON
	assetJSON, err := json.Marshal(asset)
	if err != nil {
		return err
	}

	// Store in ledger
	return ctx.GetStub().PutState(assetID, assetJSON)
}

// GetAsset retrieves an asset from the ledger
func (s *SmartContract) GetAsset(
	ctx contractapi.TransactionContextInterface,
	assetID string,
) (*Asset, error) {

	assetJSON, err := ctx.GetStub().GetState(assetID)
	if err != nil {
		return nil, fmt.Errorf("failed to read asset from ledger: %v", err)
	}

	if assetJSON == nil {
		return nil, fmt.Errorf("asset %s does not exist", assetID)
	}

	var asset Asset
	err = json.Unmarshal(assetJSON, &asset)
	if err != nil {
		return nil, err
	}

	return &asset, nil
}

// Main function to start the chaincode
func main() {

	chaincode, err := contractapi.NewChaincode(&SmartContract{})
	if err != nil {
		fmt.Printf("Error creating asset registry chaincode: %s", err)
		return
	}

	if err := chaincode.Start(); err != nil {
		fmt.Printf("Error starting asset registry chaincode: %s", err)
	}
}