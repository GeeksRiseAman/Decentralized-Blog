# Decentralized Blog

A decentralized blogging platform powered by Ethereum smart contracts. This project allows users to create, view, and like blog posts on the Ethereum blockchain.

### Features

- **Create Blog Posts**: Users can create new blog posts with a title and content.
- **Like Blog Posts**: Users can like blog posts. Each post tracks the number of likes.
- **Immutable & Decentralized**: All blog posts are stored on the Ethereum blockchain, ensuring immutability and transparency.

---

## Prerequisites

Before running the application, ensure you have the following tools and accounts:

1. **MetaMask** or any Web3-compatible wallet installed in your browser.
2. **Ethereum Testnet** or **Mainnet** (e.g., Goerli, Rinkeby, or Mainnet) for smart contract deployment.
3. **Web3.js** to interact with the Ethereum blockchain via MetaMask.
4. **Basic Knowledge of Solidity and Web3** (Optional but helpful).

---

## Installation and Setup

### 1. **Deploy the Smart Contract**

1. **Compile the Solidity Contract**:

   - Use **Remix IDE** (https://remix.ethereum.org/) to compile and deploy the contract.
   - The contract code is written in Solidity and can be deployed to an Ethereum testnet or mainnet.

2. **Deploy the Contract**:
   - After compiling, deploy the `DecentralizedBlog` contract to an Ethereum testnet (Goerli, Rinkeby) or Mainnet.
   - Once deployed, save the **contract address** and **ABI** (Application Binary Interface), which will be needed to connect the frontend to the smart contract.

### 2. **Set Up the Frontend**

1. **Clone or Download the Repository**:

   - Clone the repository or create a new folder to store the frontend files.

   ```bash
   git clone <repository-url>
   cd decentralized-blog
   ```

2. **Configure the Frontend**:

   - Open `index.html` in a text editor.
   - Replace the **contract address** and **ABI** in the frontend code:
     - Replace `"YOUR_CONTRACT_ADDRESS"` with the actual deployed contract address.
     - Replace the contract ABI with the one generated by Remix after deploying the contract.

   Example:

   ```javascript
   const contractAddress = "YOUR_CONTRACT_ADDRESS"; // Replace with your deployed contract address
   const contractABI = [
       // Replace with the ABI of your compiled contract
       ...
   ];
   ```

3. **Open the Frontend**:
   - Open `index.html` in a web browser with **MetaMask** installed.
   - When the page loads, you will see an option to connect your Ethereum wallet.

### 3. **Using the Application**

1. **Connect to Wallet**:

   - Click on the **"Connect Wallet"** button. MetaMask (or your preferred Web3 wallet) will prompt you to connect. After connecting, your wallet address will be displayed on the page.

2. **Create a Post**:

   - In the **Create a New Blog Post** section, input a **title** and **content** for your blog post.
   - Click on the **"Create Post"** button to submit the post to the Ethereum blockchain. This action will require some gas fees.

3. **View Posts**:

   - After creating a post, all blog posts will be displayed below, including the title, author, content, and the number of likes.
   - Each post has a **"Like"** button that allows users to like the post. The number of likes will increase when a user clicks the **"Like"** button.

4. **Like Posts**:
   - You can like any blog post. Each user can like a post only once.

---

## How It Works

1. **Smart Contract**:

   - The smart contract (`DecentralizedBlog.sol`) stores blog posts on the blockchain. Each post is associated with the author's address, the title, the content, the timestamp, and the number of likes.
   - The contract also emits events (`PostCreated` and `PostLiked`) for when a post is created or liked.

2. **Frontend Interaction**:
   - The frontend uses **Web3.js** to interact with the Ethereum blockchain. It reads the contract ABI and address to call the contract’s functions (`createPost`, `likePost`, `getAllPosts`).
   - The contract's data (blog posts) is fetched and displayed on the frontend, and users can interact with the contract by creating and liking posts.

---

## Contract Code (`DecentralizedBlog.sol`)

Here is the Solidity code for the `DecentralizedBlog` contract:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedBlog {
    struct Post {
        address author;
        string title;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    Post[] public posts;
    mapping(uint256 => mapping(address => bool)) public postLikes;

    event PostCreated(uint256 indexed postId, address indexed author, string title, uint256 timestamp);
    event PostLiked(uint256 indexed postId, address indexed liker);

    function createPost(string memory _title, string memory _content) public {
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_content).length > 0, "Content cannot be empty");

        Post memory newPost = Post({
            author: msg.sender,
            title: _title,
            content: _content,
            timestamp: block.timestamp,
            likes: 0
        });

        uint256 postId = posts.length;
        posts.push(newPost);

        emit PostCreated(postId, msg.sender, _title, block.timestamp);
    }

    function likePost(uint256 _postId) public {
        require(_postId < posts.length, "Invalid post ID");
        require(!postLikes[_postId][msg.sender], "You have already liked this post");

        postLikes[_postId][msg.sender] = true;
        posts[_postId].likes++;

        emit PostLiked(_postId, msg.sender);
    }

    function getAllPosts() public view returns (Post[] memory) {
        return posts;
    }
}
```

---

## Deployment on a Live Network

1. **Host the Frontend**:

   - You can host the frontend using platforms like **GitHub Pages**, **Netlify**, or **Vercel**.

2. **Use a Proper Ethereum Provider**:
   - If deploying on a public testnet like **Goerli** or **Rinkeby**, use **Infura** or **Alchemy** to set up a provider URL for Web3.js.
   - Replace the provider URL in the code if using a custom provider.

---

## Troubleshooting

- **MetaMask Issues**: Ensure MetaMask is properly configured and connected to the correct network (same one where your contract is deployed).
- **Transaction Failed**: Ensure that you have enough ETH in your MetaMask account to pay for gas fees.
- **Posts Not Displaying**: Ensure the contract address and ABI are correct. Verify the contract has been deployed correctly and is accessible from the frontend.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
