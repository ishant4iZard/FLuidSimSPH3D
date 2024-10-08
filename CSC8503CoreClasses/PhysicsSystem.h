#pragma once
#include "GameWorld.h"
#include "QuadTree.h"

namespace NCL {
	namespace CSC8503 {
		class PhysicsSystem	{
		public:
			PhysicsSystem(GameWorld& g);
			~PhysicsSystem();

			void Clear();

			void Update(float dt);

			void UseGravity(bool state) {
				applyGravity = state;
			}

			void SetGlobalDamping(float d) {
				globalDamping = d;
			}
			void SetLinearDamping(float d) {
				linearDamping = d;
			}

			void SetGravity(const Vector3& g);

			void createStaticTree();

			void SetBroadphase(bool is) {
				useBroadPhase = is;
			}
		protected:
			void BasicCollisionDetection();
			bool broadPhaseHelper(GameObject* a, GameObject* b);

			void BroadPhase();
			void NarrowPhase();

			void ClearForces();

			void IntegrateAccel(float dt);
			void IntegrateVelocity(float dt);

			void UpdateConstraints(float dt);

			void UpdateCollisionList();
			void UpdateObjectAABBs();

			void ImpulseResolveCollision(GameObject& a , GameObject&b, CollisionDetection::ContactPoint& p) const;

			GameWorld& gameWorld;

			bool	applyGravity;
			Vector3 gravity;
			float	dTOffset;
			float	globalDamping;
			float	linearDamping;



			std::set<CollisionDetection::CollisionInfo> allCollisions;
			std::set<CollisionDetection::CollisionInfo> broadphaseCollisions;
			std::vector<CollisionDetection::CollisionInfo> broadphaseCollisionsVec;

				//QuadTree <GameObject*> tree(Vector2(512,512), 10, 7);


			bool useBroadPhase		= true;
			int numCollisionFrames	= 5;

		};
	}
}

